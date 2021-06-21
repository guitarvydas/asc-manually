#!/bin/bash
cat asc.ohm asc.glue >_asc.grasem
../../grasem/run.bash _asc.grasem >_.js
cat foreign.js _.js >_ascIdentity.js
node _ascIdentity <hwapp.asc
node _ascIdentity <hwsub.asc
node _ascIdentity <hwhello.asc
node _ascIdentity <hw23.asc
node _ascIdentity <hw123.asc
