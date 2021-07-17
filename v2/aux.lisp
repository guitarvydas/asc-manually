(defparameter *top-level-components* (make-hash-table :test 'equal))

(defun is-leaf (path)
  (if (stringp path)
      'yes
      'no))

(defun lookup-or-create-component-at-top-level (cname)
  (multiple-value-bind (c success)
      (gethash cname *top-level-components*)
    (if success
	c
	(let ((c (create-component)))
	  (setf (gethash cname *top-level-components*) c)
	  c))))

(defun lookup-or-create-contained-component (parent ns name)
  (let ((namespace (gethash "c" (namespaces parent))))
    (multiple-value-bind (c success)
        (gethash name namespace)
      (if success
          c
        (let ((c (create-component)))
          (setf (gethash name namespace) c)
          c)))))

(defun lookup-component-at-top-level (name)
  (gethash name *top-level-components*))

(defun lookup-contained-component (parent ns name)
  (let ((namespace (gethash ns (namespaces parent))))
    (let ((child (gethash name namespace)))
      child)))


(defun create-input-pin-raw (component namespace name)
  (declare (ignore namespace))
  (multiple-value-bind (ns ok)
      (gethash "i" (namespaces component))
    (declare (ignore ok))
    (setf (gethash name ns) name)))

(defun create-output-pin-raw (component namespace name)
  (declare (ignore namespace))
  (multiple-value-bind (ns ok)
      (gethash "o" (namespaces component))
    (declare (ignore ok))
    (setf (gethash name ns) name)))

(defun raw-set (component ns name v)
  (let ((namespace (gethash ns (namespaces component))))
    (setf (gethash name namespace) v)))

(defun raw-get (component ns name)
  (let ((namespace (gethash ns (namespaces component))))
    (gethash name namespace)))

(defun raw-add-connection (connection-name parent-component sender-rid receiver-rid)
  (let ((namespace (gethash "x" (namespaces parent-component))))
    (setf (gethash connection-name namespace) (create-connection connection-name sender-rid receiver-rid))))

(defun panic (m)
  (error m))
