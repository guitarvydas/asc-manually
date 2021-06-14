(defstruct leafRunnable
  kind
  inputs
  outputs

  inputQueue
  outputQueue)

(defun leafRunnable-new (self)
  (setf (kind self) "compositeRunnable")
  (setf (inputs self) (new "namespace" "input"))
  (setf (outputs self) (new "namespace" "output"))
  (setf (inputQueue self) (new "queue"))
  (setf (outputQueue self) (new "queue")))

