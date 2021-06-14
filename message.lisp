(defstruct message
  tag
  data)

(defun message-new (self tag data)
  (set (tag self) tag)
  (set (data self) data))
  
