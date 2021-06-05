#!/bin/bash
set -e
echo >_.pl

echo '*** building transpilers ***'

./build.bash

./md2fb.bash app
./md2fb.bash sub

cat sub.fb
