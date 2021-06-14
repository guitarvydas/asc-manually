(defstruct output
  kind
  data)

(defun output-initially (self)
  (setf (kind self) "output")
  (name-initially self))
