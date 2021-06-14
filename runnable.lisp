(defstruct runnable
  inputQueue
  outputQueue)

(defgeneric /busy (self))
(defgeneric /ready (self))

(defgeneric /popInputQueue (self))
(defgeneric /interateOutputs (self))
