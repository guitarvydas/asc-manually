
(input (rid (rid "hwsub" "c" "_nonamekind") "i" "C"))
(output (rid (rid "hwsub" "c" "_nonamekind") "o" "D"))


(input (rid "hwsub" "i" "A"))
(output (rid "hwsub" "o" "B"))
(contains (rid "hwsub" "c" "hole") (rid "hwsub" "c" "_nonamekind"))
(connection (rid "hwsub" "x" 1) (rid "hwsub" "i" "A") (lambda (self m) (send self 'downward (rid (rid "hwsub" "c" "hole") "i" "C") m)))
(connection (rid "hwsub" "x" 2) (rid (rid "hwsub" "c" "hole") "o" "D") (lambda (self m) (send self 'upward (rid "hwsub" "o" "B") m)))

