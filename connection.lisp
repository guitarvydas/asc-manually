(defasctype "connection"
  name
  sender
  receiver)

(defun connection-new (self name sender receiver)
  (setf (name self) (name-initially self name))
  (setf (sender self) (sender-initially self sender))
  (setf (receiverer self) (receiver-initially self receiver)))

(defasctype "sender"
  component
  tag)

(defasctype "receiver"
  component
  tag)

(defun sender-new (self component tag)
  (setf (component self) component)
  (setf (tag self) tag))

(defun receiver-new (self component tag)
  (setf (component self) component)
  (setf (tag self) tag))

