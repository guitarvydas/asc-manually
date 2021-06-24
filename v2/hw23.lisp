(defun new-hw23 ()
(let ((hw23 (new-hwsub)))
    (setter-kind hw23 "hw23")
    (forget-connection hw23 (relid "." "x" "1"))
(forget-connection hw23 (relid "." "x" "2"))
(let ((hwhello (new-hwhello)))
    (add-child hw23 (relid "." "c" "hwhello") hwhello)
(add-connection hw23 (new-connection (relid "." "x" "3") (relid "." "i" "A") (lambda (self m) (send-downward self (relid (relid "." "c" "hwhello") "i" "in") m))))
    (add-connection hw23 (new-connection (relid "." "x" "4") (relid (relid "." "c" "hwhello") "o" "out") (lambda (self m) (send-upward self (relid "." "i" "B") m))))
    )
    
    hw23))


