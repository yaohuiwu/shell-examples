#!/usr/bin/env bash

k1='name'
v1='foo'

k2='age'
v2='20'

cmd='s/'"$k1"'/'"$v1"'/g;'
cmd=$cmd's/'"$k2"'/'"$v2"'/g;'
file='test.txt'

sed -i.bak "$cmd" $file 
rm -vf "${file}.bak"
