(defclass input-port ()
  ((tag :accessor tag :initarg :tag)))

(defclass output-port ()
  ((tag :accessor tag :initarg :tag)))

(defclass tag ()
  ((tag :accessor tag :initarg :tag)))

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
   (child-prototypes :accessor child-prototypes :initform (make-hash-table :test 'equal))
   (connections :accessor connections :initform (make-hash-table :test 'equal))
   (forgotten-connections :accessor forgotten-connections :initform nil)))



(defclass runnable (dispatcher-interface)
  ((inputq :accessor inputq :initform (make-instance 'queue))
   (upq :accessor upq :initform (make-instance 'queue))
   (child-instances :accessor child-instances :initform (make-hash-table :test 'equal))
   (container :accessor container :initarg :container)
   (prototype-template :accessor prototype-template :initarg :protype-template)))



;;;;;;;;
(defmacro panic (self str)
  `(let ((errormessage (format nil "~a: ~s~%" ,self ,str)))
    (error errormessage)))
;;;;;;;;
(defun new-connection (connection-name tag-name func)
  (make-instance 'connection :name connection-name :tag tag-name :action func))
;;;;;;;;
(defun new-tag (s) (make-instance 'tag :tag s))
;;;;;;;;
(defun iport (owner tagname)
  (declare (ignorable owner)) ;; should check that tagname is actually an input port of owner
  (make-instance 'input-port :tag tagname))
(defun oport (owner tagname)
  (declare (ignorable owner))
  (make-instance 'output-port :tag tagname))
;;;;;;;;

;;;;;;;;
(defmethod empty-p ((self queue))
  (null (q self)))

(defmethod pop-queue ((self queue))
  (pop (q self)))
;;;;;;;;

(defmethod add-input-port ((self asc-template) (port input-port))
  (push port (inports self)))

(defmethod add-output-port ((self asc-template) (port output-port))
  (push port (outports self)))

(defmethod add-child ((self asc-template) child-name (asc asc-template))
  (setf (gethash child-name (child-prototypes self)) asc))

(defmethod add-connection ((self asc-template) (connection connection))
  (setf (gethash (name connection) (connections self)) connection))

(defmethod forget-connection ((self asc-template) name)
  (let ((conn (gethash name (connections self))))
    (setf (gethash name (connections self)) nil)
    (push conn (forgotten-connections self))))

(defmethod setter-kind ((self asc-template) kindName)
  (setf (kind self) kindName))

;;;;;;;;

(defmethod tag= ((self tag) (other tag))
  (equal self other))

;;;;;;; runnable.lisp
(defmethod child-instances-empty-p ((self runnable))
  (zerop (hash-table-count (child-instances self))))

(defmethod map-child-instances ((self runnable) func)
  (maphash #'(lambda (k inst)
               (declare (ignore k))
               (funcall func inst))
           (child-instances self)))

(defmethod dispatch ((self runnable))
  (when (not (child-instances-empty-p self))
    (map-child-instances self #'dispatch)))

(defmethod forever ((r runnable))
  (loop
   (dispatch r)))

;;;;;;
(defmethod new-message ((tag tag) data)
  (make-instance 'message :tag tag :data data))

(defmethod display-message ((self asc-template) (m message))
  (format *standard-output* "asc ~a outputs message ~s~%" self m))

;;;;;;; engine.lisp

(defun new-runnable (template container)
  (let ((runnble (make-instance 'runnable :protoype-template template :container container)))
    (runnable-instantiate-children runnble)
    runnble))

(defmethod runnable-instantiate-children ((self runnable))
  (unless (zerop (hash-table-count (child-prototypes self)))
    (maphash #'(lambda (instance-name template)
		 (let ((instance (new-runnable template self)))
                   (setf (gethash instance-name (child-instances self)) instance)))
	     (child-prototypes self))))

(defmethod send-upward ((self runnable) (tag tag) (m message))
  (if (container self)
      (push (new-message tag (data m)) (upq (container self)))
      (display-message self m)))

(defmethod send-downward ((component runnable) (tag tag) (m message))
  (push (new-message tag (data m)) (inputq component)))

(defmethod has-work-p ((self runnable))
  (or (not (empty-p (inputq self)))
      (not (empty-p (upq self)))))

(defmethod child-instances-as-list ((self runnable))
  (let ((lis nil))
    (maphash #'(lambda (name instance)
                 (declare (ignore name))
                 (push instance lis))
             lis)))

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
  (maphash #'(lambda (name connection)
               (declare (ignore name))
               (when (tag= (tag m) (tag connection))
                 (funcall (action connection) self m)))
           (connections (prototype-template self))))

(defmethod exec ((self runnable))
  (if (not (empty-p (upq self)))
      (let ((m (pop-queue (upq self))))
	(process-message self m))
    (if (not (empty-p (inputq self)))
        (let ((m (pop-queue (inputq self))))
          (process-message self m))
      (panic self "internal error - exec called but no message is available"))))
	  

(defmethod dispatch-message ((self runnable))
  ;; dispatch-message means: input one message and run it to completion (a: if leaf node, just run the appropriate code, b: if composite node, copy the message to the appropriate children)
  ;; dispatch depth-first: deepest child first (dispatch deepest child, then quit)
  ;; if no child has work, dispatch self
  (let ((left-most-deepest (left-most-deepest-ready self (if (ready-p self) self nil))))
    (when left-most-deepest
      (exec left-most-deepest))))

(defmethod left-most-deepest-ready ((self runnable) lmd)
  ;; return first child that is ready, doing a left depth-first search
  ;; avoid the issue of fairness, address it later if needed
  ;; (optimistic view: all actual work will be done quickly and fairness will not be an issue,
  ;; one component can only hog the process if messages are fedback to it)
  (if (child-instances-empty-p self)
      lmd
      (mapc #'(lambda (child)
		(let ((child-lmd (left-most-deepest-ready child nil)))
		  (when child-lmd
		    (return-from left-most-deepest-ready child-lmd))))
	    (child-instances-as-list (if (ready-p self) self nil)))))
  
