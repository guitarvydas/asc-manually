(defclass app/c/1 (asc))

(defmethod initially ((self app/c/1))
  (setf (inports self) '("./i/a"))
  (setf (outports self) '("./o/b"))
  (setf (children self) nil)
  (call-next-method))

(defmethod react ((self app/c/1) (m message))
  (cond ((tag= "./i/a")
	 (delegate self m))
	((tag= "./o/b")
	 (send-upward self "." "o/out"))
	(t (panic self "component not resolved yet"))))


(defclass app (asc)

(defmethod initially ((self app))
  (setf (inports self) '("./i/in"))
  (setf (outports self) '("./o/out"))
  (setf (children self) (children-map "./c/1" app/c/1))
  (call-next-method))

(defmethod react ((self app) (m message))
  (save-message self message)
  (econd
   ((tag= m "." "./i/in")
    (send-downward self "./c/1" "./i/a" m)
   ((tag= m "./c/1" "./o/b")
    (send-upward self "." "./o/out" m)
