(defun new-hw123 ()
(let ((hw123 (new-hwapp)))
    (setter-kind hw123 "hw123")
    (forget-connection hw123 (relid "." "x" "1"))
(forget-connection hw123 (relid "." "x" "2"))
(let ((hw23 (new-hw23)))
    (add-child hw123 (relid "." "c" "hw23") hw23)
(add-connection hw123 (new-connection (relid "." "x" "3") (relid "." "i" "in") (lambda (self m) (send-downward self (relid (relid "." "c" "hw23") "i" "A") m))))
    (add-connection hw123 (new-connection (relid "." "x" "4") (relid (relid "." "c" "hw23") "o" "B") (lambda (self m) (send-upward self (relid "." "o" "out") m))))
    )
    
    hw123))


