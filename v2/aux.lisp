(defparameter *top-level-components* (make-hash-table :test 'equal))

(defun is-leaf (path)
  (stringp path))

(defun set-value-raw (cname ns name v)
  (let ((component (lookup-component-top-level cname)))
    (let ((namespace (gethash ns component)))
      (setf (gethash name namespace) v))))

(defun panic (m)
  (error m))

(defun lookup-component-top-level (cname)
  (gethash cname *top-level-components*))

(defun lookup-value (cname ns name)
  (let ((component (lookup-component-top-level cname)))
    (let ((namespace (gethash ns component)))
      (gethash name namespace))))

(defun def-component-raw (rid)
  ;; install component at top level
  (let ((cname (path rid)))
    (setf (gethash cname *top-level-components*) (create-component))))