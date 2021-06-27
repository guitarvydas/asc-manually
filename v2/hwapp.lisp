(def (rid hwapp c _nonamekind))
(input (ref (rid hwapp c _nonamekind)) (def (rid hwapp/c/_nonamekind i in)))
(output (ref (rid hwapp c _nonamekind)) (def (rid hwapp/c/_nonamekind o out)))

(def hwapp)
(input (ref hwapp) (def (rid hwapp i in)))
(output (ref hwapp) (def (rid hwapp o out)))
(contains (ref hwapp) (ref (rid hwapp c inner)) (clone (ref (rid hwapp c _nonamekind))))
(connection (ref hwapp) (def (rid hwapp x 1)) (on (ref (rid hwapp i in)) (send 'downward (ref (rid hwapp/c/inner i in)) m)))
(connection (ref hwapp) (def (rid hwapp x 2)) (on (ref (rid hwapp/c/inner o out)) (send 'upward (ref (rid hwapp o out)) m)))


