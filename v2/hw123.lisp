(def (rid ""hw123" "c" "hwapp" "c" "hwsub"" ""c"" ""hwhello""))
(input (ref-component (rid ""hw123" "c" "hwapp" "c" "hwsub"" ""c"" ""hwhello"")) "i" (def (rid ""hw123" "c" "hwapp" "c" "hwsub" "c" "hwhello"" ""i"" ""in"")))
(output (ref-component (rid ""hw123" "c" "hwapp" "c" "hwsub"" ""c"" ""hwhello"")) "o" (def (rid ""hw123" "c" "hwapp" "c" "hwsub" "c" "hwhello"" ""o"" ""out"")))
(text (ref-component (rid ""hw123" "c" "hwapp" "c" "hwsub"" ""c"" ""hwhello"")) "n" (def (rid ""hw123" "c" "hwapp" "c" "hwsub" "c" "hwhello"" ""n"" ""code"")) "hello")
(connection (ref-component (rid ""hw123" "c" "hwapp" "c" "hwsub"" ""c"" ""hwhello"")) "x" (def (rid ""hw123" "c" "hwapp" "c" "hwsub" "c" "hwhello"" ""x"" "1")) (on (ref (rid ""hw123" "c" "hwapp" "c" "hwsub" "c" "hwhello"" ""i"" ""in"")) (call (ref (rid ""hw123" "c" "hwapp" "c" "hwsub" "c" "hwhello"" ""n"" ""code"")))(send 'upward (ref (rid ""hw123" "c" "hwapp" "c" "hwsub" "c" "hwhello"" ""o"" ""out"")) (tospop))))
(def (rid ""hw123" "c" "hwapp" "c" "hwsub"" ""c"" ""_nonamekind""))
(input (ref-component (rid ""hw123" "c" "hwapp" "c" "hwsub"" ""c"" ""_nonamekind"")) "i" (def (rid ""hw123" "c" "hwapp" "c" "hwsub" "c" "_nonamekind"" ""i"" ""C"")))
(output (ref-component (rid ""hw123" "c" "hwapp" "c" "hwsub"" ""c"" ""_nonamekind"")) "o" (def (rid ""hw123" "c" "hwapp" "c" "hwsub" "c" "_nonamekind"" ""o"" ""D"")))

(def (rid ""hw123" "c" "hwapp"" ""c"" ""hwsub""))
(input (ref-component (rid ""hw123" "c" "hwapp"" ""c"" ""hwsub"")) "i" (def (rid ""hw123" "c" "hwapp" "c" "hwsub"" ""i"" ""A"")))
(output (ref-component (rid ""hw123" "c" "hwapp"" ""c"" ""hwsub"")) "o" (def (rid ""hw123" "c" "hwapp" "c" "hwsub"" ""o"" ""B"")))
(contains (ref-component (rid ""hw123" "c" "hwapp"" ""c"" ""hwsub"")) "c" (clone (ref (rid ""hw123" "c" "hwapp" "c" "hwsub"" ""c"" ""_nonamekind""))))
(connection (ref-component (rid ""hw123" "c" "hwapp"" ""c"" ""hwsub"")) "x" (def (rid ""hw123" "c" "hwapp" "c" "hwsub"" ""x"" "1")) (on (ref (rid ""hw123" "c" "hwapp" "c" "hwsub"" ""i"" ""in"")) (send 'downward (ref (rid ""hw123" "c" "hwapp" "c" "hwsub" "c" "hole"" ""i"" ""C"")) m)))
(connection (ref-component (rid ""hw123" "c" "hwapp"" ""c"" ""hwsub"")) "x" (def (rid ""hw123" "c" "hwapp" "c" "hwsub"" ""x"" "2")) (on (ref (rid ""hw123" "c" "hwapp" "c" "hwsub" "c" "hole"" ""o"" ""D"")) (send 'upward (ref (rid ""hw123" "c" "hwapp" "c" "hwsub"" ""o"" ""B"")) m)))
(def (rid ""hw123" "c" "hwapp"" ""c"" ""_nonamekind""))
(input (ref-component (rid ""hw123" "c" "hwapp"" ""c"" ""_nonamekind"")) "i" (def (rid ""hw123" "c" "hwapp" "c" "_nonamekind"" ""i"" ""in"")))
(output (ref-component (rid ""hw123" "c" "hwapp"" ""c"" ""_nonamekind"")) "o" (def (rid ""hw123" "c" "hwapp" "c" "_nonamekind"" ""o"" ""out"")))

(def (rid ""hw123"" ""c"" ""hwapp""))
(input (ref-component (rid ""hw123"" ""c"" ""hwapp"")) "i" (def (rid ""hw123" "c" "hwapp"" ""i"" ""in"")))
(output (ref-component (rid ""hw123"" ""c"" ""hwapp"")) "o" (def (rid ""hw123" "c" "hwapp"" ""o"" ""out"")))
(contains (ref-component (rid ""hw123"" ""c"" ""hwapp"")) "c" (clone (ref (rid ""hw123" "c" "hwapp"" ""c"" ""_nonamekind""))))
(connection (ref-component (rid ""hw123"" ""c"" ""hwapp"")) "x" (def (rid ""hw123" "c" "hwapp"" ""x"" "1")) (on (ref (rid ""hw123" "c" "hwapp"" ""i"" ""in"")) (send 'downward (ref (rid ""hw123" "c" "hwapp" "c" "inner"" ""i"" ""in"")) m)))
(connection (ref-component (rid ""hw123"" ""c"" ""hwapp"")) "x" (def (rid ""hw123" "c" "hwapp"" ""x"" "2")) (on (ref (rid ""hw123" "c" "hwapp" "c" "inner"" ""o"" ""out"")) (send 'upward (ref (rid ""hw123" "c" "hwapp"" ""o"" ""out"")) m)))


