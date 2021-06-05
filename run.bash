#!/bin/bash
target=app
set -e
echo >_.pl

echo '*** building transpilers ***'

./build.bash

./md2fb.bash app

cat ${target}.fb
