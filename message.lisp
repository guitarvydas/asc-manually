(defstruct message
  tag
  data)

(defun message-initially ())

(defun message-new (tag data)
  (let ((self (make-message)))
    (set (tag self) tag)
    (set (data self) data)
    self))
  
