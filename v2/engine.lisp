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
  ((tag :accessor tag :initarg :tag)
   (action :accessor action :initarg :action)))

(defclass queue () 
  ((q :accessor q :initform nil)))

(defclass asc-template ()
  ((kind :accessor kind :initform "<noname kind>" :initarg :kind)
   (inports :accessor inports :initform (make-instance 'queue))
   (outports :accessor outports :initform (make-instance 'queue))
   (child-templates :accessor child-templates :initform (make-hash-table :test 'equal))
   (reaction :accessor reaction :initform nil)
   (connections :accessor connections :initform nil)))




(defclass runnable ()
  ((inputq :accessor inputq :initform (make-instance 'queue))
   (upq :accessor upq :initform (make-instance 'queue))
   (child-instances :accessor child-instances :initform (make-hash-table :test 'equal))
   (container :accessor container :initform nil)))


(defclass dispatcher-interface () ())

(defclass dispatcher (dispatcher-interface)
  ((top :accessor top)))

(defclass asc-runnable (asc-template runnable dispatcher-interface)
  ((child-instances :accessor child-instances :initform (make-hash-table :test 'equal))))

;;;;;;;;
(defun new-tag (s) (make-instance 'tag :tag s))
;;;;;;;;

;;;;;;;;
(defmethod empty-p ((self queue))
  (null (q self)))
;;;;;;;;

(defmethod setter-kind ((self asc-template) s)
  (setf (kind self) s))

(defmethod add-input-port ((self asc-template) (port input-port))
  (push port (inports self)))

(defmethod add-output-port ((self asc-template) (port output-port))
  (push port (outports self)))

(defmethod add-child ((self asc-template) name (asc asc-template))
  (setf (gethash name (child-templates self)) asc))

(defmethod add-connection ((self asc-template) (connection connection))
  (push connection (connections self)))

(defmethod get-child ((self asc-template) name)
  (gethash name (child-templates self)))
;;;;;;;;

(defmethod tag= ((self tag) (other tag))
  (equal self other))

;;;;;;; runnable.lisp
(defmethod dispatch ((self asc-runnable))
  (when (not (child-instances-empty-p self))
    (map-child-instances self #'dispatch)))

(defmethod setter-top ((d dispatcher-interface) (top-asc asc-runnable))
  (setf (top d) top-asc))

(defmethod forever ((d dispatcher-interface))
  (loop 
    (dispatch (top d))))

;;;;;;
(defmethod new-message ((tag tag) data)
  (make-instance 'message :tag tag :data data))

(defmethod display-message ((self asc-template) (m message))
  (format *standard-output* "asc ~a outputs message ~s~%" self m))

;;;;;;; engine.lisp

(defmethod send-upward ((self asc-template) (tag tag) (m message))
  (if (container self)
      (push (new-message tag (data m)) (upq (container self)))
      (display-message self m)))

(defmethod send-downward ((component asc-template) (tag tag) (m message))
  (push (new-message tag (data m)) (inputq component)))

(defmethod busy-p ((self asc-template))
  (every #'(lambda (child) (not (ready-p child))) (children-instances self)))

(defmethod ready-p ((self asc-template))
  (or (not (empty-p (inputq self)))
      (not (empty-p (upq self)))))

(defmethod react ((self asc-template) (m message))
  (mapc #'(lambda (connection)
	    (when (tag= (tag m) (tag connection))
	      (funcall (action connection) self m)))
	(connections self)))

(defmethod dispatcher (top)
  (dispatch top))
