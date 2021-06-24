(defclass relative-id ()
  ((path :accessor path :initarg :path) ;; "." or relative-id (recursive)
   (ns :accessor ns :initarg :ns)  ;; namespace i/o/x/c/n
   (id :accessor id :initarg :id))) ;; a name within the given namespace

(defclass message ()
  ((tag :accessor tag :initarg :tag)
   (data :accessor data :initarg :data)))

(defclass connection ()
  ((name :accessor name :initarg :name)
   (tag :accessor tag :initarg :tag)
   (action :accessor action :initarg :action)))

(defclass queue () 
  ((q :accessor q :initform nil)))

(defclass asc-template ()
  ((kind :accessor kind :initform "<noname kind>" :initarg :kind)
   (inports :accessor inports :initform nil)
   (outports :accessor outports :initform nil)
   (child-prototypes :accessor child-prototypes :initform (make-hash-table :test 'tag=))
   (connections :accessor connections :initform (make-hash-table :test 'tag=))
   (forgotten-connections :accessor forgotten-connections :initform nil)))



(defclass runnable ()
  ((inputq :accessor inputq :initform (make-instance 'queue))
   (upq :accessor upq :initform (make-instance 'queue))
   (child-instances :accessor child-instances :initform (make-hash-table :test 'tag=))
   (container :accessor container :initarg :container)
   (prototype-template :accessor prototype-template :initarg :prototype-template)))



;;;;;;;;
(defmacro panic (self str)
  `(let ((errormessage (format nil "internal error ~a: ~s~%" ,self ,str)))
    (error errormessage)))

(defun empty-hash-p (h)
  (zerop (hash-table-count h)))
;;;;;;;;
(defun relid (p namespace id)
  (make-instance 'relative-id :path p :ns namespace :id id))

(defmethod print-object ((rid relative-id) ostream)
  (format ostream "[~a ~a ~a]" (path rid) (ns rid) (id rid)))

;;;;;;;;
(defun new-connection (connection-name relid func)
  (make-instance 'connection :name connection-name :tag relid :action func))
;;;;;;;;
;;;;;;;;

;;;;;;;;
(defmethod empty-p ((self queue))
  (null (q self)))

(defmethod pop-queue ((self queue))
  (pop (q self)))

(defmethod push-queue ((self queue) v)
  (push v (q self)))
;;;;;;;;

(defmethod add-input-port ((self asc-template) (port relative-id))
  (push port (inports self)))

(defmethod add-output-port ((self asc-template) (port relative-id))
  (push port (outports self)))

(defmethod add-child ((self asc-template) child-name (asc asc-template))
  (setf (gethash child-name (child-prototypes self)) asc))

(defmethod add-connection ((self asc-template) (connection connection))
  (setf (gethash (name connection) (connections self)) connection))

(defmethod forget-connection ((self asc-template) tag)
  (let ((conn (gethash tag (connections self))))
    (setf (gethash tag (connections self)) nil)
    (push conn (forgotten-connections self))))

(defmethod setter-kind ((self asc-template) kindName)
  (setf (kind self) kindName))

(defmethod debug ((self asc-template) out)
  (format out "kind ~a~%" (kind self))
  (mapc #'(lambda (x) (format out "input port ~a~%" x)) (inports self))
  (mapc #'(lambda (x) (format out "output port ~a~%" x)) (outports self))
  (maphash #'(lambda (name template)
	       (declare (ignore template))
	       (format out "child: ~a~%" name))
	   (child-prototypes self))
  (when (not (empty-hash-p (connections self)))
    (maphash #'(lambda (nm connection)
                 (if connection
                     (format out "connection: ~a [~a]~%" nm (name connection))
                     (format out "connection: ~a nil~%" nm (name connection))))
	     (connections self)))
  (when (forgotten-connections self)
    (mapc #'(lambda (connection) 
	      (format out "forgotten connection: ~a~%" (name connection)))
	  (forgotten-connections self)))
  (format out "~%~%"))
;;;;;;;;

(defmethod tag= ((self relative-id) (other relative-id))
  (and 
   (equal (path self) (path other))
   (equal (ns self) (ns other))
   (equal (id self) (id other))))

;;;;;;; runnable.lisp
(defmethod child-instances-empty-p ((self runnable))
  (zerop (hash-table-count (child-instances self))))

(defmethod map-child-instances ((self runnable) func)
  (maphash #'(lambda (k inst)
               (declare (ignore k))
               (funcall func inst))
           (child-instances self)))

;;;;;;
(defmethod new-message ((tag relative-id) data)
  (make-instance 'message :tag tag :data data))

(defmethod display-message ((self runnable) (m message))
  (format *standard-output* "asc ~a outputs message ~s~%" self m))

(defmethod display-proto-message ((self runnable) (tag relative-id) data)
  (format *standard-output* "asc ~a outputs message ~s ~s~%" self tag data))

;;;;;;; engine.lisp

(defun new-runnable (template container)
  (format *standard-output* "new-runnable ~S~%" (kind template))
  (let ((r (make-instance 'runnable :prototype-template template :container container)))
    (runnable-instantiate-children r)
    r))

(defmethod runnable-instantiate-children ((self runnable))
  (unless (zerop (hash-table-count (child-prototypes (prototype-template self))))
    (maphash #'(lambda (instance-name template)
		 (let ((instance (new-runnable template self)))
(format *standard-output* "ric: ~a ~a~%" instance-name (kind template))
                   (setf (gethash instance-name (child-instances self)) instance)))
	     (child-prototypes (prototype-template self)))))

(defmethod send-upward ((self runnable) (tag relative-id) data)
  (if (container self)
      (push-queue (upq (container self)) (new-message tag data))
      (display-proto-message self tag data)))

(defmethod send-downward ((component runnable) (tag relative-id) data)
  (push-queue (inputq component) (new-message tag data)))

(defmethod has-work-p ((self runnable))
  (or (not (empty-p (inputq self)))
      (not (empty-p (upq self)))))

(defmethod child-instances-as-list ((self runnable))
  (let ((lis nil))
    (unless (empty-hash-p (child-instances self))
      (maphash #'(lambda (name instance)
                   (declare (ignore name))
                   (push instance lis))
               (child-instances self)))
    lis))

(defmethod busy-p ((self runnable))
  ;; a component is busy if it has anything in either input queue, or
  ;; if any of its children as busy
  (or 
   (has-work-p self)
   (some #'busy-p (child-instances-as-list self))))

(defmethod ready-p ((self runnable))
   (has-work-p self))

(defmethod process-message ((self runnable) (m message))
  ;; this needs locking if running asynchronously (e.g. on bare metal without an operating system)
(format *standard-output* "~%process message ~a~%" (kind (prototype-template self)))
  (let ((done nil))
    (maphash #'(lambda (name connection)
                 (declare (ignorable name))
(format *standard-output* "connection ~a  tag = ~a connection.tag=~a~%" name (tag m) (if connection (tag connection) nil))
                 (when (and connection (tag= (tag m) (tag connection)))
		   (push name done)
                   (funcall (action connection) self m)))
             (connections (prototype-template self)))
    (when done
      (format *standard-output* "process message fired ~s ~s ~s~%" (tag m) (data m) done))
    (unless done
      (panic self (format nil "process-message did not fire any action ~s ~s" (tag m) (data m))))))

(defmethod exec ((self runnable))
  (if (not (empty-p (upq self)))
      (let ((m (pop-queue (upq self))))
	(process-message self m))
    (if (not (empty-p (inputq self)))
        (let ((m (pop-queue (inputq self))))
          (process-message self m))
      (panic self "internal error - exec called but no message is available"))))
	  

(defmethod dispatch ((self runnable))
  ;; dispatch-message means: input one message and run it to completion (a: if leaf node, just run the appropriate code, b: if composite node, copy the message to the appropriate children)
  ;; dispatch depth-first: deepest child first (dispatch deepest child, then quit)
  ;; if no child has work, dispatch self
  (let ((left-most-deepest (left-most-deepest-ready self (if (ready-p self) self nil))))
    (if left-most-deepest
        (let ()
          (exec left-most-deepest)
          left-most-deepest)
      nil)))

(defmethod dispatch-until-done ((self runnable))
  (let ((r (dispatch self)))
    (when r
      (dispatch-until-done self))))
  

(defmethod left-most-deepest-ready ((self runnable) lmd)
  ;; return first child that is ready, doing a left depth-first search
  ;; avoid the issue of fairness, address it later if needed
  ;; (optimistic view: all actual work will be done quickly and fairness will not be an issue,
  ;; one component can only hog the process if messages are fedback to it)
  (if (child-instances-empty-p self)
      lmd
    (when (child-instances-as-list self)
      (mapc #'(lambda (child)
		(let ((child-lmd (left-most-deepest-ready child nil)))
		  (when child-lmd
		    (return-from left-most-deepest-ready child-lmd))))
	    (child-instances-as-list self))))
  lmd) ;; reaches here only if all children are not ready
  
