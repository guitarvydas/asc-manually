(defun new-hw123 ()
(let ((hw123 (new-hwapp)))
    (setter-kind hw123 "hw123")
    (forget-connection hw123 "./x-1")
(forget-connection hw123 "./x-2")
(let ((hw23 (new-hw23)))
    (add-child hw123 (kind hw23) hw23)
(add-connection hw123 (new-connection "./x-3" (iport hw123 "in") (lambda (self m) (send-downward self (iport hw23 "A") m))))
    (add-connection hw123 (new-connection "./x-4" (oport hw23 "B") (lambda (self m) (send-downward self (oport hw123 "out") m))))
    )
    
    hw123))


