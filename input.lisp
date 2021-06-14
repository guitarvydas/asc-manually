(defasctype "input"
  data)

(defun input-initially ())

(defun input-new ()
  (let ((self (make-input)))
    (name-new self)
    self))
