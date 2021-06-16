#!/bin/bash

# ./gentypes.bash

../grasem/run.bash ascty.grasem >_.js
cat genforeign.js _.js >ascty.js
node ascty.js <types.ty
