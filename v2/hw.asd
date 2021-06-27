(defsystem :hw
  :around-compile (lambda (next)
                    (proclaim '(optimize (debug 3) (safety 3) (speed 0)))
                    (funcall next))
  :components ((:module "source"
                :pathname "./"
			:components (
				     (:file "engine")
				     (:file "mechanisms")
				     (:file "hwapp")
				     (:file "hwsub")
				     (:file "hwhello")
				     (:file "hw123")
				     ))))

