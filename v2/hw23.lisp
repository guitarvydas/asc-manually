
(input (rid (rid "hw23" "c" (rid "1" "c" "_nonamekind")) "i" "C"))
(output (rid (rid "hw23" "c" (rid "1" "c" "_nonamekind")) "o" "D"))


(input (rid (rid "hw23" "c" "1") "i" "A"))
(output (rid (rid "hw23" "c" "1") "o" "B"))
(contains (rid (rid "hw23" "c" "1") "c" "hole") (rid (rid "hw23" "c" "1") "k" "_nonamekind"))
(connection (rid (rid "hw23" "c" "1") "x" "1") (rid (rid "hw23" "c" "1") "i" "A") (lambda (self m) (send self 'downward (rid (rid "hw23" "c" (rid "1" "c" "hole")) "i" "C") m)))
(connection (rid (rid "hw23" "c" "1") "x" "2") (rid (rid "hw23" "c" (rid "1" "c" "hole")) "o" "D") (lambda (self m) (send self 'upward (rid (rid "hw23" "c" "1") "o" "B") m)))
(input (rid (rid "hw23" "c" "2") "i" "in"))
(output (rid (rid "hw23" "c" "2") "o" "out"))
(text (rid (rid "hw23" "c" "2") "n" "code") "hello")
(connection (rid (rid "hw23" "c" "2") "x" "1") (rid (rid "hw23" "c" "2") "i" "in") (lambda (self m) (call (rid (rid "hw23" "c" "2") "n" "code"))(send self 'upward (rid (rid "hw23" "c" "2") "o" "out") (tospop))))
(connection (rid "hw23" "x" "1") (rid (rid "hw23" "c" (rid "1" "c" "hole")) "i" "C") (lambda (self m) (send self 'downward (rid (rid "hw23" "c" "2") "i" "in") m)))
(connection (rid "hw23" "x" "2") (rid (rid "hw23" "c" "2") "o" "out") (lambda (self m) (send self 'upward (rid (rid "hw23" "c" (rid "1" "c" "hole")) "o" "D") m)))

