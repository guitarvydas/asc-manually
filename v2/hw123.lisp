
(input (rid (rid "hw123" "c" (rid "2" "c" (rid "1" "c" "_nonamekind"))) "i" "C"))
(output (rid (rid "hw123" "c" (rid "2" "c" (rid "1" "c" "_nonamekind"))) "o" "D"))


(input (rid (rid "hw123" "c" (rid "2" "c" "1")) "i" "A"))
(output (rid (rid "hw123" "c" (rid "2" "c" "1")) "o" "B"))
(contains (rid (rid "hw123" "c" (rid "2" "c" "1")) "c" "hole") (rid (rid "hw123" "c" (rid "2" "c" "1")) "n" "_nonamekind"))
(connection (rid (rid "hw123" "c" (rid "2" "c" "1")) "x" "1") (rid (rid "hw123" "c" (rid "2" "c" "1")) "i" "A") (lambda (self m) (send self 'downward (rid (rid "hw123" "c" (rid "2" "c" (rid "1" "c" "hole"))) "i" "C") m)))
(connection (rid (rid "hw123" "c" (rid "2" "c" "1")) "x" "2") (rid (rid "hw123" "c" (rid "2" "c" (rid "1" "c" "hole"))) "o" "D") (lambda (self m) (send self 'upward (rid (rid "hw123" "c" (rid "2" "c" "1")) "o" "B") m)))
(input (rid (rid "hw123" "c" (rid "2" "c" "2")) "i" "in"))
(output (rid (rid "hw123" "c" (rid "2" "c" "2")) "o" "out"))
(text (rid (rid "hw123" "c" (rid "2" "c" "2")) "n" "code") "hello")
(connection (rid (rid "hw123" "c" (rid "2" "c" "2")) "x" "1") (rid (rid "hw123" "c" (rid "2" "c" "2")) "i" "in") (lambda (self m) (call (rid (rid "hw123" "c" (rid "2" "c" "2")) "n" "code"))(send self 'upward (rid (rid "hw123" "c" (rid "2" "c" "2")) "o" "out") (tospop))))
(connection (rid (rid "hw123" "c" "2") "x" "1") (rid (rid "hw123" "c" (rid "2" "c" (rid "1" "c" "hole"))) "i" "C") (lambda (self m) (send self 'downward (rid (rid "hw123" "c" (rid "2" "c" "2")) "i" "in") m)))
(connection (rid (rid "hw123" "c" "2") "x" "2") (rid (rid "hw123" "c" (rid "2" "c" "2")) "o" "out") (lambda (self m) (send self 'upward (rid (rid "hw123" "c" (rid "2" "c" (rid "1" "c" "hole"))) "o" "D") m)))

(input (rid (rid "hw123" "c" (rid "1" "c" "_nonamekind")) "i" "in"))
(output (rid (rid "hw123" "c" (rid "1" "c" "_nonamekind")) "o" "out"))


(input (rid (rid "hw123" "c" "1") "i" "in"))
(output (rid (rid "hw123" "c" "1") "o" "out"))
(contains (rid (rid "hw123" "c" "1") "c" "inner") (rid (rid "hw123" "c" "1") "c" "_nonamekind"))
(connection (rid (rid "hw123" "c" "1") "x" "1") (rid (rid "hw123" "c" "1") "i" "in") (lambda (self m) (send self 'downward (rid (rid "hw123" "c" (rid "1" "c" "inner")) "i" "in") m)))
(connection (rid (rid "hw123" "c" "1") "x" "2") (rid (rid "hw123" "c" (rid "1" "c" "inner")) "o" "out") (lambda (self m) (send self 'upward (rid (rid "hw123" "c" "1") "o" "out") m)))

(connection (rid "hw123" "x" "a3") (rid (rid "hwapp" "c" "inner") "i" "in") (lambda (self m) (send self 'downward (rid (rid "hwapp" "c" "2") "i" "A") m)))
(connection (rid "hw123" "x" "a4") (rid (rid "hwapp" "c" "hw23") "o" "B") (lambda (self m) (send self 'upward (rid (rid "hwapp" "c" "inner") "c" "out") m)))

