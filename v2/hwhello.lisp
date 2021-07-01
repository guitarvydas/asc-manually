(input (rid "hwhello" "i" "in"))
(output (rid "hwhello" "o" "out"))
(text (rid "hwhello" "n" "code") "hello")
(connection (rid "hwhello" "x" 1) (rid "hwhello" "i" "in") (lambda (self m) (call (rid "hwhello" "n" "code"))(send self 'upward (rid "hwhello" "o" "out") (tospop))))

