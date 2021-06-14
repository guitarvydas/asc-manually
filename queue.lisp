(defasctype "queue"
  q)

(defun queue-initially ())

(defun queue-new ()
  (let ((self (make-queue)))
    (setf (q self) nil)
    self))

