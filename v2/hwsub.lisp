(def (rid hwsub c _nonamekind))
(input (ref (rid hwsub c _nonamekind)) (def (rid hwsub/c/_nonamekind i C)))
(output (ref (rid hwsub c _nonamekind)) (def (rid hwsub/c/_nonamekind o D)))

(def hwsub)
(input (ref hwsub) (def (rid hwsub i A)))
(output (ref hwsub) (def (rid hwsub o B)))
(contains (ref hwsub) (ref (rid hsub c hole)) (clone (ref (rid hwsub c _nonamekind))))
(connection (ref hwsub) (def (rid hwsub x 1)) (on (ref (rid hwsub i in)) (send 'downward (ref (rid hwsub/c/hole i C)) m)))
(connection (ref hwsub) (def (rid hwsub x 2)) (on (ref (rid hwsub/c/hole o D)) (send 'upward (ref (rid hwsub o B)) m)))

