(defasctype "namespace"
  hashtable
  itemKind)

(defun namespace-initially (kind))

(defun namespace-new (kind)
  (let ((self (make-namespace)))
    (setf (namespace-hashtable self) (make-hash-table :test 'equal))
    (setf (namespace-itemKind self) kind)
    self))
