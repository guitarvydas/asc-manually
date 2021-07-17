(defun test ()
  (setf *top-level-components* (make-hash-table :test 'equal))
  (def-top-level-component% "hwapp")
  (def-contained-component% (create-rid "hwapp" "c" "inner"))
  (def-input% (create-rid "hwapp" "i" "in"))
  (def-output% (create-rid "hwapp" "o" "out"))
  (def-input% (create-rid (create-rid "hwapp" "c" "inner") "i" "a"))
  (def-output% (create-rid (create-rid "hwapp" "c" "inner") "o" "b"))
  (add-connection% (create-rid "hwapp" "x" "1") (create-rid "hwapp" "i" "in") (create-rid (create-rid "hwapp" "c" "inner") "i" "a"))
  (add-connection% (create-rid "hwapp" "x" "2")  (create-rid (create-rid "hwapp" "c" "inner") "o" "b") (create-rid "hwapp" "o" "out"))

  (def-top-level-component% "hwsub")
  (def-contained-component% (create-rid "hwsub" "c" "hwhello"))
  (def-input% (create-rid "hwsub" "i" "x"))
  (def-output% (create-rid "hwsub" "o" "y"))
  (def-input% (create-rid (create-rid "hwsub" "c" "hwhello") "i" "r"))
  (def-output% (create-rid (create-rid "hwsub" "c" "hwhello") "o" "s"))
  (add-connection% (create-rid "hwsub" "x" "1") (create-rid "hwsub" "i" "x") (create-rid (create-rid "hwsub" "c" "hwhello") "i" "r"))
  (add-connection% (create-rid "hwsub" "x" "2")  (create-rid (create-rid "hwsub" "c" "hwhello") "o" "s") (create-rid "hwsub" "o" "y"))
		   
)

