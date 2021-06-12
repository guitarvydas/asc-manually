#!/bin/bash
target=$1
set -x
# expand ./c/x/i/z to app/c/x/i/z
node _mdexpanddot <$target.md >_nd.md
#cat hwexp-nd.md
# expand app/c/x/i/z to ((app c c) i z)
node _mdexpandname <_nd.md >_exp.md
#cat hwexp.md

## names fully expanded in .md form
cp _exp.md ${target}_e.md

## pretty print .md to .fb
node _md2block.js < _exp.md > _.block
node _block2brace.js < _.block > _.brace
txl _.brace fbpp.txl >$target.fb
