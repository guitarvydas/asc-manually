#!/bin/bash
clear
set -e
trap 'catch' ERR

catch () {
    echo '*** fatal error in run.bash'
    exit 1
}

echo >_.pl

echo '*** building transpilers ***'

./build.bash

echo '*** transpiling md files ***'
# # ./md2fb.bash app
# # ./md2fb.bash sub
# # ./md2fb.bash hello

# # # dev
# # node _md2block.js < test.md > _.block
# # node _block2brace.js < _.block > _.brace
# # node _brace2fb.js < _.brace | ./trimfacts > test.fb

# ./md2fb.bash test3a
# awk -f ind1.awk <test3a.fb >m0.fb
# awk -f fb2pl.awk <m0.fb >m0.pl
# cat m0.pl


