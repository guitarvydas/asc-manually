(defun new-hwsub ()
(let ((hwsub (make-instance 'asc-template :kind "hwsub")))
    (add-input-port hwsub (make-instance 'input-port :tag "A"))
(add-output-port hwsub (make-instance 'output-port :tag "B"))
(add-child hwsub "hwsub/c-hole"
(let ((hwsub/c-hole (make-instance 'asc-template :kind "hwsub/c-hole")))
    (add-input-port hwsub/c-hole (make-instance 'input-port :tag "C"))
(add-output-port hwsub/c-hole (make-instance 'output-port :tag "D"))

    hwsub/c-hole)

)
    (add-connection hwsub (new-connection "./x-1" "A" (lambda (self m) (send-downward self C m))))
    (add-connection hwsub (new-connection "./x-2" "D" (lambda (self m) (send-upward self B m))))
    
    (debug hwsub *standard-output*)
    hwsub))


