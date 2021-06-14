(defstruct compositeRunnable
  kind
  inputs
  outputs
  children
  connections

  inputQueue
  outputQueue)

(defun compositeRunnable-new (self)
  (setf (kind self) "compositeRunnable")
  (setf (inputs self) (new "namespace" "input"))
  (setf (outputs self) (new "namespace" "output"))
  (setf (children self) (new "namespace" "component"))
  (setf (connections self) (new "namespace" "connection"))
  (setf (inputQueue self) (new "queue"))
  (setf (outputQueue self) (new "queue")))
