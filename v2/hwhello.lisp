(defmethod initially ((self hello))
  (setf (inports self) '("./i/1"))
  (setf (outports self) '("./0/1"))
  (call-next-method))

(defmethod react ((self hello) (m message))
  (save-message self message)
  (cond
    ((tag= message self "./i/1")
     (let ((result (fhello self m)))
       (send-upwards self "./o/1" result)))))

(defun fhello (self message) 
  "Hello")
