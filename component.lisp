(defstruct component
  kind
  inputs
  outputs)

(defgeneric initially (self))
(defgeneric react (self message))
