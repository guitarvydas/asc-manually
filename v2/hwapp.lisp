
(input (rid (rid "hwapp" "c" "_nonamekind") "i" "in"))
(output (rid (rid "hwapp" "c" "_nonamekind") "o" "out"))


(input (rid "hwapp" "i" "in"))
(output (rid "hwapp" "o" "out"))
(contains (rid "hwapp" "c" "inner") (rid "hwapp" "c" "_nonamekind"))
(connection (rid "hwapp" "x" 1) (rid "hwapp" "i" "in") (lambda (self m) (send self 'downward (rid (rid "hwapp" "c" "inner") "i" "in") m)))
(connection (rid "hwapp" "x" 2) (rid (rid "hwapp" "c" "inner") "o" "out") (lambda (self m) (send self 'upward (rid "hwapp" "o" "out") m)))


