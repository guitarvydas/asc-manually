(def (rid "hwapp" "c" "_nonamekind"))
(input (ref-component (rid "hwapp" "c" "_nonamekind")) "i" (def (rid (rid "hwapp" "c" "_nonamekind") "i" "in")))
(output (ref-component (rid "hwapp" "c" "_nonamekind")) "o" (def (rid (rid "hwapp" "c" "_nonamekind") "o" "out")))

(def "hwapp")
(input (ref-component "hwapp") "i" (def (rid "hwapp" "i" "in")))
(output (ref-component "hwapp") "o" (def (rid "hwapp" "o" "out")))
(contains (ref-component "hwapp") "c" (clone (ref (rid "hwapp" "c" "_nonamekind"))))
(connection (ref-component "hwapp") "x" (def (rid "hwapp" "x" 1)) (on (ref (rid "hwapp" "i" "in")) (send 'downward (ref (rid (rid "hwapp" "c" "inner") "i" "in")) m)))
(connection (ref-component "hwapp") "x" (def (rid "hwapp" "x" 2)) (on (ref (rid (rid "hwapp" "c" "inner") "o" "out")) (send 'upward (ref (rid "hwapp" "o" "out")) m)))


