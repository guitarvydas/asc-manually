(def "hwhello")
(input (ref-component "hwhello") "i" (def (rid ""hwhello"" ""i"" ""in"")))
(output (ref-component "hwhello") "o" (def (rid ""hwhello"" ""o"" ""out"")))
(text (ref-component "hwhello") "n" (def (rid ""hwhello"" ""n"" ""code"")) "hello")
(connection (ref-component "hwhello") "x" (def (rid ""hwhello"" ""x"" "1")) (on (ref (rid ""hwhello"" ""i"" ""in"")) (call (ref (rid ""hwhello"" ""n"" ""code"")))(send 'upward (ref (rid ""hwhello"" ""o"" ""out"")) (tospop))))

