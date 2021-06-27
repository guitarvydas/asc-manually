#!/bin/sh
sed -E -e 's~hwhello~hwsub/c/hwhello~g' <hwhello.asc >_temp1.asc
cat _temp1.asc hwsub.asc | sed -E -e 's~hwsub~hwapp/c/hwsub~g' >_temp2.asc
cat _temp2.asc hwapp.asc | sed -E -e 's~hwapp~hw123/c/hwapp~g' >hw123.asc

