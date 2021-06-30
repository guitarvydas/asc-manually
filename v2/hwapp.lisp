(defasc (rid "hwapp" "c" "_nonamekind"))
(input (rid (rid "hwapp" "c" "_nonamekind") "i" "in"))
(output (rid (rid "hwapp" "c" "_nonamekind") "o" "out"))

(defasc "hwapp")
(input (rid "hwapp" "i" "in"))
(output (rid "hwapp" "o" "out"))
(contains (rid "hwapp" "c" "inner") (rid "hwapp" "c" "_nonamekind"))
(connection (rid "hwapp" "x" 1) (on (rid "hwapp" "i" "in") (send 'downward (rid (rid "hwapp" "c" "inner") "i" "in") m)))
(connection (rid "hwapp" "x" 2) (on (rid (rid "hwapp" "c" "inner") "o" "out") (send 'upward (rid "hwapp" "o" "out") m)))


