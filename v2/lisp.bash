#!/bin/bash
cat asc.ohm lisp.glue >_asclisp.grasem
../../grasem/run.bash _asclisp.grasem >_.js
cat foreign.js _.js >_ascLisp.js
node _ascLisp <hwapp.asc
node _ascLisp <hwsub.asc
node _ascLisp <hwhello.asc
node _ascLisp <hw23.asc
node _ascLisp <hw123.asc
