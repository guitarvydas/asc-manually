(defasctype "component"
  kind
  inputs
  outputs)

(defun component-initially (self)
)

(defun component-new ()
  (let ((self (make-component)))
    (setf (kind self) "component")
    (setf (inputs self) (input-new))
    (setf (outputs self) (output-new))
    self))
 
(defgeneric initially (self))
(defgeneric react (self message))
