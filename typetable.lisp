(defparameter *asctypes*
  (make-hash-table :test 'equal))

(defun asctypes-initially ()
  (setf (gethash "component" *asctypes*) (list component-initially component-new))
  (setf (gethash "composite" *asctypes*) composite-initially)
  (setf (gethash "compositeRunnable" *asctypes*) compositeRunnable-initially)
  (setf (gethash "leafRunnable" *asctypes*) leafRunnable-initially)
  (setf (gethash "connection" *asctypes*) connection-initially)
  (setf (gethash "message" *asctypes*) message-initially)
  (setf (gethash "namespace" *asctypes*) nil)
  (setf (gethash "input" *asctypes*) input-initially)
  (setf (gethash "output" *asctypes*) output-initially)
  (setf (gethash "sender" *asctypes*) sender-initially)
  (setf (gethash "receiver" *asctypes*) receiver-initially)
  (setf (gethash "queue" *asctypes*) queue-initially)
  (setf (gethash "runnable" *asctypes*) runnable-initially)
  (setf (gethash "name" *asctypes*) name-initially))
  
