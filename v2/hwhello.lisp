(defun new-hwhello ()
  (let ((self (make-instance 'asc-template :kind "hwhello")))
    (add-input-port self (new-iport "in"))
    (add-output-port self (new-oport "out"))
    (add-connection self (make-instance 'connection
					:name "./x:1" 
					:tag "in"
					:action #'(lambda (self m)
						    (declare (ignorable self m))
						    (send-upward self "out" (hello)))))
    self))
