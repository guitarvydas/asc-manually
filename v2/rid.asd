(defsystem :rid
  :around-compile (lambda (next)
                    (proclaim '(optimize (debug 3) (safety 3) (speed 0)))
                    (funcall next))
  :components ((:module "source"
                :pathname "./"
			:components (
				     (:file "classes")
				     (:file "aux")
				     (:file "design-rule")
				     (:file "engine")
				     (:file "test")
				     ))))

