#!/bin/bash
clear
set -e
echo >_.pl

echo '*** building transpilers ***'

./build.bash

echo '*** transpiling md files ***'
./md2fb.bash app
./md2fb.bash sub
./md2fb.bash hello
cat hello.fb

