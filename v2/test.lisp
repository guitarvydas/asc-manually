(defun test ()
  (let ((hw123 (new-hw123)))
    (let ((run (new-runnable hw123 nil)))
      (send-downward run (relid "." "i" "in") t)
      (dispatch-until-done run))))
;;      (forever run))))
