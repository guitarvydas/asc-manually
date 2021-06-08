#!/bin/bash
set -e
trap 'catch' ERR

catch () {
    echo '*** fatal error in build.bash'
    exit 1
}

../grasem/run.bash md2block.grasem >_.js
cat foreign.js _.js >_md2block.js

../grasem/run.bash block2brace.grasem >_.js
cat foreign.js _.js >_block2brace.js

m4 <brace2fb.grasem >_.grasem
../grasem/run.bash _.grasem >_.js
cat foreign.js _.js >_brace2fb.js
