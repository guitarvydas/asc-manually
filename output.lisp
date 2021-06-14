(defstruct output
  data)

(defun output-initially ())

(defun output-new ()
  (let ((self (make-output)))
    (name-new self)
    self)
