#!/bin/bash
set -e
set -x
trap 'catch' ERR

catch () {
    echo '*** fatal error in md2fb.bash'
    exit 1
}
node _md2block.js < $1.md > _.block
node _block2brace.js < _.block > _.brace
node _brace2fb.js < _.brace >./emit
./trimfacts <./emit > $1.fb
