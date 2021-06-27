;; "rid" means "relative id"
;; rid is a 3-tuple - 1) component, 2) namespace, 3) name

(defmacro def (rid)
  (error-if (exists rid) (format nil "id already exists ~a~%" rid))
  (define-rid rid)
  (lookup-rid rid))

(defmacro ref (rid)
  (error-if-not (exists rid) (format nil "id does not exist ~a~%" rid))
  (lookup-rid rid))

(defmacro ref-component (rid)
  (error-if-not (exists rid) (format nil "id does not exist ~a~%" rid))
  (lookup-rid-component rid))

(defmacro rid (path ns id)
  `(relative-id :path path :namespace ns :id id))



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
    (setf (gethash "n" (namespaces c)) (make-hash-table :test 'equal))))
	

(defparameter *component-table* (make-hash-table :test 'equal))

(defun define-rid (rid)
  (let ((c (gethash (path rid) *component-table*)))
    (unless c
      (setf c (make-component))
      (setf (gethash (path rid) *component-table*) c))
    (let ((namespace ((ns path) c)))
      (setf (gethash (id rid) namespace) rid))))
    
(defun lookup-rid-internal (rid)
  ;; lookup the rid (for now, in a flat table)
  ;; return nil if not found
  ;; return non-nil if found (currently, return the component)
  (let ((c (gethash (path rid) *component-table*)))
    (unless c
      (return-from lookup-rid nil))
    (let ((namespace ((ns path) c)))
      (multiple-value-bind (name sucess) (gethash (id rid) namespace)
	(if success
	    (values t c namespcace name)
	    (values nil nil nil nil))))))

(defun lookup-rid (rid)
  (multiple-value-bind (success component ns name)
      (lookup-rid-internal rid)
    (if success
	rid
	nil)))

(defun lookup-rid-component (rid)
  (multiple-value-bind (success component ns name)
      (lookup-rid-internal rid)
    (if success
	component
	nil)))



(defun exists (rid)
  (let ((r (lookup-rid)))
    (if r
	t
	nil)))

(defun error-if (expr estring)
  (when expr
    (error estring)))

(defun error-if-not (expr estring)
  (error-if (not expr) estring))

;;;;;;;;;;;; engine

(defun input (component ns iport-rid) 
  (setf (gethash iport-rid (gethash ns component)) iport-rid))

(defun output (component ns oport-rid) 
  (setf (gethash oport-rid (gethash ns component)) oport-rid))

(defun text (component ns rid str)
  (setf (gethash rid (gethash ns component) str)))

(defun connection (component ns rid action)
  (setf (gethash rid (gethash ns component) action)))

(defun contains (component ns child-rid)
  (setf (gethash child-rid (gethash ns component) child-rid)))
