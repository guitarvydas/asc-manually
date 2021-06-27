(def (rid ""hwsub"" ""c"" ""_nonamekind""))
(input (ref-component (rid ""hwsub"" ""c"" ""_nonamekind"")) "i" (def (rid ""hwsub" "c" "_nonamekind"" ""i"" ""C"")))
(output (ref-component (rid ""hwsub"" ""c"" ""_nonamekind"")) "o" (def (rid ""hwsub" "c" "_nonamekind"" ""o"" ""D"")))

(def "hwsub")
(input (ref-component "hwsub") "i" (def (rid ""hwsub"" ""i"" ""A"")))
(output (ref-component "hwsub") "o" (def (rid ""hwsub"" ""o"" ""B"")))
(contains (ref-component "hwsub") "c" (clone (ref (rid ""hwsub"" ""c"" ""_nonamekind""))))
(connection (ref-component "hwsub") "x" (def (rid ""hwsub"" ""x"" "1")) (on (ref (rid ""hwsub"" ""i"" ""in"")) (send 'downward (ref (rid ""hwsub" "c" "hole"" ""i"" ""C"")) m)))
(connection (ref-component "hwsub") "x" (def (rid ""hwsub"" ""x"" "2")) (on (ref (rid ""hwsub" "c" "hole"" ""o"" ""D"")) (send 'upward (ref (rid ""hwsub"" ""o"" ""B"")) m)))

