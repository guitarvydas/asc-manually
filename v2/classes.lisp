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
  ((i :accessor i :initform (create-namespace))
   (o :accessor o :initform (create-namespace))
   (c :accessor c :initform (create-namespace))
   (n :accessor b :initform (create-namespace))))

(defun create-component ()
  (make-instance 'component))
