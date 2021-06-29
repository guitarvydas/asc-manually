;; "rid" means "relative id"
;; rid is a 3-tuple - 1) component, 2) namespace, 3) name

(defclass relative-id ()
  ((path :accessor path :initarg :path)
   (ns :accessor ns :initarg :namespace)
   (id :accessor id :initarg :id)))

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

(defun lookup (name)
  (gethash name *component-table*))

(defun %design-rule-failure (message)
  (let ((s (concatenate 'string "design rule failure: " message)))
    (error s)))

;; see rid-dsl
(defmethod getter ((rid relative-id))
  (with-slots (ns id) rid
    (let ((c (ea rid)))
      (gethash id
               (gethash ns (namespaces c))))))

(defmethod setter ((rid relative-id) val)
  (with-slots (ns id) rid
    (let ((c (ea rid)))
      (multiple-value-bind (_ success)
          (gethash id (gethash ns (namespaces c)))
        (declare (ignore _))
        (when success
          (%design-rule-failure "must not already have a value"))
        (setf (gethash id (gethash ns (namespaces c))) val)))))

(defmethod def ((rid relative-id))
  (ea rid))

(defmethod ea-raw ((rid relative-id))
  (cond ((stringp (path rid))
	 (let ((result (lookup (path rid))))
	   (unless result
	     (%design-rule-failure "must not be empty"))
	   result))
	(t
	 (let ((ref (path rid)))
	   (unless (string= "c" (ns ref))
	     (%design-rule-failure "must contain a component namespace reference"))
	   (let ((result (getter ref)))
	     result)))))

(defmethod ea ((rid relative-id))
  (let ((result (ea rid)))
    (unless (eq 'component (type-of result))
      (%design-rule-failure "must be a component"))
    result))
	
;;;;;;;;;

(defun error-if (expr estring)
  (when expr
    (error estring)))

(defun error-if-not (expr estring)
  (error-if (not expr) estring))

;;;;;;;;;;;; engine

(defun new-component (rid)
  (def rid rid))

(defun input (iport-rid) 
  (def iport-rid iport-rid))

(defun output (oport-rid) 
  (def oport-rid))

(defun text (rid str)
  (setter rid str))

(defun connection (rid action)
  (setter rid action))

(defun contains (parent-rid child-rid)
  (setter parent-rid `(contains ,child-rid)))
