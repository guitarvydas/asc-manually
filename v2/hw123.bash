#!/bin/bash
cat hw23.asc hwapp.asc >hw123.asc

sed -E -e 's~hwapp~hw123/c/1~g' <hw123.asc >temp ; mv temp hw123.asc
sed -E -e 's~hw23~hw123/c/2~g' <hw123.asc >temp ; mv temp hw123.asc

echo 'connection hw123 hw123/x/a3 on hwapp/c/inner/i/in (@forward downward hwapp/c/2/i/A)' >>hw123.asc
echo 'connection hw123 hw123/x/a4 on hwapp/c/hw23/o/B (@forward upward hwapp/c/inner/c/out)' >>hw123.asc
