#!/bin/bash
set -e
trap 'catch' ERR

catch () {
    echo '*** fatal error in md2fb.bash'
    exit 1
}
node _md2block.js < $1.md > _.block
node _block2brace.js < _.block > _.brace
node _brace2fb.js < _.brace | ./trimfacts > $1.fb
