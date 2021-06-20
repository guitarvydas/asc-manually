(defclass final (hw123 runnable))

(defun run-app ()
  (let ((app (make-instance 'final)))
    (inject app "./i/in" true)))
