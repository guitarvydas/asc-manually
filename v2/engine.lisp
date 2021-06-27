;; "rid" means "relative id"
;; rid is a 3-tuple - 1) component, 2) namespace, 3) name

(defclass relative-id ()
  ((path :accessor path :initarg :path)
   (ns :accessor ns :initarg :namespace)
   (id :accessor id :initarg :id)))

(defun def (rid)
  (error-if (exists rid) (format nil "id already exists ~a~%" rid))
  (define-rid rid)
  (lookup-rid rid))

(defmacro ref (rid)
  `(progn
     (error-if-not (exists ,rid) (format nil "id does not exist ~a~%" ,rid))
     (lookup-rid ,rid)))

(defmacro ref-component (rid)
  `(progn
     (error-if-not (exists ,rid) (format nil "id does not exist ~a~%" ,rid))
     (lookup-rid-component ,rid)))

(defmacro rid (path ns id)
  `(make-instance 'relative-id :path ,path :namespace ,ns :id ,id))



;;;;;;;;; rid utilities

(defclass component ()
  ;; each component has 5 namespaces i,o,x,c,n
  ;; (input, output, connection, component, other-names, resp.)
  ((namespaces :accessor namespaces :initform (make-hash-table :test 'equal))))

(defun make-component ()
  (let ((c (make-instance 'component)))
    (setf (gethash "i" (namespaces c)) (make-hash-table :test 'equal))
    (setf (gethash "o" (namespaces c)) (make-hash-table :test 'equal))
    (setf (gethash "x" (namespaces c)) (make-hash-table :test 'equal))
    (setf (gethash "c" (namespaces c)) (make-hash-table :test 'equal))
    (setf (gethash "n" (namespaces c)) (make-hash-table :test 'equal))
    c))
	

(defparameter *component-table* (make-hash-table :test 'equal))

(defun define-rid (rid)
  (let ((c (gethash (path rid) *component-table*)))
    (unless c
      (setf c (make-component))
      (setf (gethash (path rid) *component-table*) c))
    (let ((namespace (gethash (ns rid) (namespaces c))))
      (setf (gethash (id rid) namespace) rid))
    c))
    
(defun lookup-rid-internal (rid)
  ;; lookup the rid (for now, in a flat table)
  ;; return nil if not found
  ;; return non-nil if found (currently, return the component)
  (let ((c (gethash (path rid) *component-table*)))
    (unless c
      (return-from lookup-rid-internal (values nil nil nil nil)))
    (let ((namespace (gethash (ns rid) (namespaces c))))
      (multiple-value-bind (name success) (gethash (id rid) namespace)
	(if success
	    (values t c namespace name)
	    (values nil nil nil nil))))))

(defun lookup-rid (rid)
  (multiple-value-bind (success component ns name)
      (lookup-rid-internal rid)
    (declare (ignore component ns name))
    (if success
	rid
	nil)))

(defun lookup-rid-component (rid)
  (multiple-value-bind (success component ns name)
      (lookup-rid-internal rid)
    (declare (ignore ns name))
    (if success
	component
	nil)))



(defun exists (rid)
  (let ((r (lookup-rid rid)))
    (if r
	t
	nil)))

(defun error-if (expr estring)
  (when expr
    (error estring)))

(defun error-if-not (expr estring)
  (error-if (not expr) estring))

;;;;;;;;;;;; engine

(defun input (iport-rid) 
  (define-rid iport-rid))

(defun output (component ns oport-rid) 
  (setf (gethash oport-rid (gethash ns component)) oport-rid))

(defun text (component ns rid str)
  (setf (gethash rid (gethash ns component)) str))

(defun connection (component ns rid action)
  (setf (gethash rid (gethash ns component)) action))

(defun contains (component ns child-rid)
  (setf (gethash child-rid (gethash ns component)) child-rid))
