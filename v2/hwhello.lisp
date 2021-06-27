(def hwhello)
(input (ref hwhello) (def (rid hwhello i in)))
(output (ref hwhello) (def (rid hwhello o out)))
(text (ref hwhello) (def (rid hwhello n code)) "hello")
(connection (ref hwhello) (def (rid hwhello x 1)) (on (ref (rid hwhello i in)) (call (ref (rid hwhello n code)))(send 'upward (ref (rid hwhello o out)) (tospop))))

