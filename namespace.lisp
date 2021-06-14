(defstruct namespace
  hashtable
  itemKind)

(defun namespace-initially (self kind)
  (setf (namespace-hashtable self) (make-hash-table :test 'equal))
  (setf (namespace-itemKind self) kind))
