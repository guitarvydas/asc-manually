#!/bin/bash
clear
set -e
trap 'catch' ERR

catch () {
    echo '*** fatal error in run.bash'
    exit 1
}

echo >_.pl

set -x 
echo '*** building transpilers ***'

./build.bash

# ./devexp.bash hw
# # hw.fb contains expanded, pp'ed diagram

# ./devexp.bash hwsub

# # echo '*** transpiling md files ***'
# # ./devmd2fb.bash hw8
# # awk -f ./fb2pl.awk <hw8.fb >hw8.pl
# # cat hw8.pl

./devexp.bash hwfinal
cat hwfinal.fb
