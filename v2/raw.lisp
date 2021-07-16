(defun set-value-raw (c ns v)
  (setf (gethash ns c) v))
        