(defun new-hwhello ()
(let ((hwhello (make-instance 'asc-template :kind "hwhello")))
    (add-input-port hwhello (relid "." "i" "in"))
(add-output-port hwhello (relid "." "o" "out"))
(add-connection hwhello (new-connection (relid "." "x" "1") (relid "." "i" "in") (lambda (self m) (hello)
(send-upward self (relid "." "i" "out") m))))
    
    hwhello))


