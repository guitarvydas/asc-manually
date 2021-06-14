(defasctype "name"
    str)

(defun name-initially ()
)  

(defun name-new (str)
  (let ((self (make-name)))
    (setf (str self) str)
    self))
