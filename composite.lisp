(defasctype "composite"
  kind
  inputs
  outputs
  children
  connections)

(defun composite-initially ()
  )

(defun composite-new ()
  (let ((self (make-component)))
    (setf (kind self) "composite")
    (setf (inputs self) (input-new))
    (setf (outputs self) (output-new))
    (setf (children self) (namespace-new))
    (setf (connections self) (namespace-new))
    self))
  
