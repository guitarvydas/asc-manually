(defun new-hwhello ()
  (let ((hwhello (make-instance 'asc-template :kind "hwhello")))
    (add-input-port hwhello (make-instance 'input-port :tag "in"))
    (add-output-port hwhello (make-instance 'output-port :tag "out"))
    (add-connection hwhello (new-connection "./x-1" "in" (lambda (self m) (hello)
                                                           (send-upward self out m))))
    
    (debug hwhello *standard-output*)
    hwhello))


