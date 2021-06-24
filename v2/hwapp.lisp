(defun new-hwapp ()
(let ((hwapp (make-instance 'asc-template :kind "hwapp")))
    (add-input-port hwapp (relid "." "i" "in"))
(add-output-port hwapp (relid "." "o" "out"))
(add-child hwapp "inner"
(let ((inner (make-instance 'asc-template :kind "inner")))
    (add-input-port inner (relid "." "i" "in"))
(add-output-port inner (relid "." "o" "out"))

    inner)

)
    (add-connection hwapp (new-connection (relid "." "x" "1") (relid "." "i" "in") (lambda (self m) (send-downward self (relid (relid "." "c" "inner") "i" "in") m))))
    (add-connection hwapp (new-connection (relid "." "x" "2") (relid (relid "." "c" "inner") "o" "out") (lambda (self m) (send-upward self (relid "." "o" "out") m))))
    
    hwapp))


