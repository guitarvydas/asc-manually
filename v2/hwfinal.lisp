(defclass hwfinal (hw123 asc-runnable) ())

(defmethod instantiate-template ((self hwfinal))
  (call-next-method))


(defparameter *dispatcher* (make-instance 'dispatcher))
(defparameter *app* (make-instance 'hwfinal))

(defun test ()
  (let ((test-template (make-instance 'hw23)))
    (instantiate-template test-template)
    test-template))
  

;(setter-top *dispatcher* *app*)
;(dispatch *app*)
