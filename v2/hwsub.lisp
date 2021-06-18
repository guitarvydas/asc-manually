(defclass hwsub/c/1 (asc))
  
(defmethod intially ((self hwsub/c/1))
  (setf (inports self) '("./i/a"))
  (setf (outports self) '("./o/b"))
  (setf (children self) nil)
  (call-next-method))

(defmethod react ((self hwsub/c/1) (m message))
  (cond ((tag= "./i/in")
	 (send-downward self m))
	(t (panic self m))))



(defclass hwsub (asc))

(defmethod initially ((self hwsub))
  (setf (inports self) '("./i/x"))
  (setf (outports self) '("./o/y"))
  (setf (children self) (list "./c/1" (make-instance 'hwsub/c/1))
  (call-next-method))

(defmethod react ((self hwsub) (message message)
  (save-message self message)
  (econd
   ((tag= message "." "./i/x")
    (send-downward self "./c/1" "./i/r" message)
   ((tag= message "./c/1" "./o/b")
    (send-upward self "./o/y" message)

      
