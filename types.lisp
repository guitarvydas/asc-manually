(defparameter *asctypes*
  (make-hash-table :test 'equal))

(defun asctypes-new ()
  (setf (gethash "component" *asctypes*) nil)
  (setf (gethash "namespace" *asctypes*) nil)
  (setf (gethash "input" *asctypes*) input-new)
  (setf (gethash "output" *asctypes*) output-new)
  (setf (gethash "connection" *asctypes*) connection-new)
  (setf (gethash "sender" *asctypes*) sender-new)
  (setf (gethash "receiver" *asctypes*) receiver-new)
  (setf (gethash "queue" *asctypes*) queue-new)
  (setf (gethash "name" *asctypes*) name-new))
  
