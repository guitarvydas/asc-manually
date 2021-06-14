(defasctype "runnable"
  inputQueue
  outputQueue)

(defun runnable-initially ())

(defun runnable-new ()
  (let ((self (make-runnable)))
    (setf (inputQueue self) (inputQueue-new))
    (setf (outputQueue self) (outputQueue-new))
    self))

(defgeneric /busy (self))
(defgeneric /ready (self))

(defgeneric /popInputQueue (self))
(defgeneric /interateOutputs (self))
