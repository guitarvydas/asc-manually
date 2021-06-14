(defstruct input
  kind
  data)

(defun input-initially (self)
  (setf (kind self) "input")
  (name-initially self))
