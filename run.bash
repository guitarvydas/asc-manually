#!/bin/bash
target=app
set -e
echo >_.pl

echo '*** building transpilers ***'
../grasem/run.bash md2block.grasem >_.js
cat foreign.js _.js >_md2block.js

../grasem/run.bash block2brace.grasem >_.js
cat foreign.js _.js >_block2brace.js

../grasem/run.bash brace2fb.grasem >_.js
cat foreign.js _.js >_brace2fb.js



# node _dasl.js < $target.dasl >> _.pl

# awk -f name-mangling.awk < _.pl | sort > fb.pl
# cat fb.pl


