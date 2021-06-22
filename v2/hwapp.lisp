(defun new-hwapp ()
  (let ((hwapp (make-instance 'asc-template :kind "hwapp")))
    (add-input-port hwapp (make-instance 'input-port :tag "in"))
    (add-output-port hwapp (make-instance 'output-port :tag "out"))
    (add-child hwapp "hwapp/c:inner"
               (let ((inner (make-instance 'asc-template :kind "inner")))
                 (add-input-port inner (make-instance 'input-port :tag "in"))
                 (add-output-port inner (make-instance 'output-port :tag "out"))

                 inner)

               )
    (add-connection hwapp (new-connection "./x-1" "in" (lambda (self m) (send-downward self inner/i-in m))))
    (add-connection hwapp (new-connection "./x-2" "inner/o-out" (lambda (self m) (send-upward self out m))))
    
    (debug hwapp *standard-output*)
    hwapp))


