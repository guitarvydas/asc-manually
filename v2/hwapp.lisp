(defclass inner-567 (asc-template) ())

(defclass hwapp (asc-template) ())

(defmethod template-initially ((self hwapp))
  (add-input-port self (make-instance 'input-port :tag "./i/in"))
  (add-output-port self (make-instance 'output-port :tag "./o/out"))
  (let ((c/1 (make-instance 'inner-567)))
    (template-initially c/1)
    (add-child c/1 (new-tag "./c/1") c/1))
  (add-connection self (make-instance 'connection :tag "./i/a" :action (lambda (m) (send-downward self "./c/1/i/a" m))))
  (add-connection self (make-instance 'connection :tag "./c/1/o/b" :action (lambda (m) (send-upward self "./o/out" m)))))

(defmethod template-initially ((self inner-567))
  (map-child-templates self #'instantiate-template)
  (add-input-port self (make-instance 'input-port :tag "./i/a"))
  (add-output-port self (make-instance 'output-port :tag "./o/b")))
