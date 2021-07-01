#!/bin/bash
cat hwsub.asc hwhello.asc >hw23.asc

sed -E -e 's~hwsub~hw23/c/1~g' <hw23.asc >temp ; mv temp hw23.asc
sed -E -e 's~hwhello~hw23/c/2~g' <hw23.asc >temp ; mv temp hw23.asc

echo 'connection hw23 hw23/x/1 on hw23/c/1/c/hole/i/C (@forward downward hw23/c/2/i/in)' >>hw23.asc
echo 'connection hw23 hw23/x/2 on hw23/c/2/o/out (@forward upward hw23/c/1/c/hole/o/D)' >>hw23.asc
