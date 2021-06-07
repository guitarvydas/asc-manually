#!/bin/bash
clear
set -e
echo >_.pl

echo '*** building transpilers ***'

./build.bash

echo '*** transpiling md files ***'
# ./md2fb.bash app
# ./md2fb.bash sub
# ./md2fb.bash hello

# dev
node _md2block.js < app.md > _.block
node _block2brace.js < _.block > _.brace
# node _brace2fb.js < _.brace | ./trimfacts > app.fb
cat _.brace

