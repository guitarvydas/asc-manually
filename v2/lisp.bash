#!/bin/bash
clear
set -e
trap 'catch' ERR

catch () {
    echo '*** fatal error in run.bash'
    exit 1
}
cat asc.ohm lisp.glue >_asclisp.grasem
../../grasem/run.bash _asclisp.grasem >_.js
cat foreign.js _.js >_ascLisp.js
node _ascLisp <hwapp.asc >hwapp.lisp
#node _ascLisp <hwsub.asc >hwsub.lisp
#node _ascLisp <hwhello.asc >hwhello.lisp
#./hw.bash
#node _ascLisp <hw23.asc >hw23.lisp
#node _ascLisp <hw123.asc >hw123.lisp
# cat hwapp.lisp hwsub.lisp hwhello.lisp hw23.lisp hw123.lisp
cat hwapp.lisp
