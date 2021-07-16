(defparameter *top-level-components* (make-hash-table :test 'equal))

(defun is-leaf (path)
  (if (stringp path)
      'yes
      'no))

(defun raw-set-value (component ns name v)
  (let ((namespace (gethash ns (namespaces component))))
    (setf (gethash name namespace) v)))

(defun raw-get-value (cname ns name)
  (let ((component (lookup-component-at-top-level cname)))
    (let ((namespace (gethash ns (namespaces component))))
      (gethash name namespace))))

(defun lookup-or-create-component-at-top-level (cname)
  (multiple-value-bind (c success)
      (gethash cname *top-level-components*)
    (if success
	c
	(let ((c (create-component)))
	  (setf (gethash cname *top-level-components*) c)
	  c))))

(defun lookup-or-create-contained-component (parent ns name)
  (let ((namespace (gethash ns (namespaces parent))))
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

(defun create-raw-input (parent ns name)
  (create-raw ns name))
(defun create-raw-output (parent ns name)
  (create-raw ns name))
(defun create-raw (ns name)
  (setf (gethash name ns) name))

(defun resolve-component-raw (container ns name)
  (let ((namespace (gethash ns container)))
    (let ((result (gethash name namespace)))
      result)))

(defun panic (m)
  (error m))
