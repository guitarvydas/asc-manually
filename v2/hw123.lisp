(defclass hw123 (hwapp) ())

(defmethod instantiate-template ((self hw123))
  (add-child self (new-tag "./c/1") (make-instance 'hw23))
  (map-child-templates self #'instantiate-template)
  (add-connection self (make-instance 'connection :tag "./c/1/i/a" :action (lambda (m) (send-downward self "./c/2/i/xx" m))))
  (add-connection self (make-instance 'connection :tag "./c/2/o/yy" :action (lambda (m) (send-upward self "./c/1/o/b" m))))
  (call-next-method))
