(defun new-hwsub ()
(let ((hwsub (make-instance 'asc-template :kind "hwsub")))
    (add-input-port hwsub (relid "." "i" "A"))
(add-output-port hwsub (relid "." "o" "B"))
(add-child hwsub "hole"
(let ((hole (make-instance 'asc-template :kind "hole")))
    (add-input-port hole (relid (relid "." "c" "hole") "i" "C"))
(add-output-port hole (relid (relid "." "c" "hole") "o" "D"))

    hole)

)
    (add-connection hwsub (new-connection (relid "." "x" "1") (relid "." "i" "A") (lambda (self m) (send-downward self (relid (relid "." "c" "hole") "i" "C") m))))
    (add-connection hwsub (new-connection (relid "." "x" "2") (relid (relid "." "c" "hole") "o" "D") (lambda (self m) (send-upward self (relid "." "o" "B") m))))
    
    hwsub))


