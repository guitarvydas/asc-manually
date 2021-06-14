(defasctype "leafRunnable"
  kind
  inputs
  outputs

  inputQueue
  outputQueue)

(defun leafRunnable-initially (self))

(defun leafRunnable-new ()
  (let ((self (make-leafRunnable)))
    (setf (kind self) "compositeRunnable")
    (setf (inputs self) (new "namespace" "input"))
    (setf (outputs self) (new "namespace" "output"))
    (setf (inputQueue self) (new "queue"))
    (setf (outputQueue self) (new "queue"))
    self))

