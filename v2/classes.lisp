(defclass rid ()
  ((path :accessor path :initarg :path)
   (ns :accessor ns :initarg :ns)
   (name :accessor name :initarg :name)))

(defun create-rid (p ns name)
  (let ((r (make-instance 'rid :path p :ns ns :name name)))
    r))

(defun create-namespace ()
  (make-hash-table :test 'equal))

(defclass component ()
  ((namespaces :accessor namespaces :initarg :namespaces)))

(defun create-component ()
  (let ((c (make-instance 'component)))
    (let ((hash (make-hash-table :test 'equal)))
      (setf (gethash "i" hash) (create-namespace))
      (setf (gethash "o" hash) (create-namespace))
      (setf (gethash "c" hash) (create-namespace))
      (setf (gethash "n" hash) (create-namespace))
      (setf (namespaces c) hash)
      c)))
