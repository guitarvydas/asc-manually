#!/bin/bash
set -e
echo >_.pl

echo '*** building transpilers ***'

./build.bash

./md2fb.bash app
./md2fb.bash sub
./md2fb.bash hello

cat hello.fb
