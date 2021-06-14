(defasctype "connection"
  name
  sender
  receiver)

(defun connection-initially () )

(defun connection-new (name sender receiver)
  (let ((self (make-connection)))
    (setf (name self) (name-new self name))
    (setf (sender self) (sender-new self sender))
    (setf (receiverer self) (receiver-new self receiver))
    self))

(defasctype "sender"
  component
  tag)

(defasctype "receiver"
  component
  tag)

(defun sender-initially ())

(defun sender-new (component tag)
  (let ((self (make-sender)))
    (setf (component self) component)
    (setf (tag self) tag)
    self))

(defun receiver-initially ())

(defun receiver-new (component tag)
  (let ((self (make-receiver)))
    (setf (component self) component)
    (setf (tag self) tag)
    self))

