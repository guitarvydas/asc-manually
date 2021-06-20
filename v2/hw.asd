(defsystem :hw
  :around-compile (lambda (next)
                    (proclaim '(optimize (debug 3) (safety 3) (speed 0)))
                    (funcall next))
  :components ((:module "source"
                :pathname "./"
			:components (
				     (:file "engine")
				     (:file "hwhello")
				     (:file "hwsub")
				     (:file "hwapp")
				     (:file "hw23")
				     (:file "hw123")
				     (:file "hwfinal")
				     ))))

