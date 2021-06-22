(defun new-hw23 ()
(let ((hw23 (new-hwsub)))
    (setter-kind hw23 "hw23")
    (forget-connection hw23 "./x-1")
(forget-connection hw23 "./x-2")
(let ((hwhello (new-hwhello)))
    (add-child hw23 (kind hwhello) hwhello)
(add-connection hw23 (new-connection "./x-3" (iport hw23 "A") (lambda (self m) (send-downward self (iport hwhello "in") m))))
    (add-connection hw23 (new-connection "./x-4" (oport hw23 "out") (lambda (self m) (send-downward self (iport hw23 "B") m))))
    )
    
    hw23))


