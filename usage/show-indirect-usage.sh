#!/usr/bin/env bash

foo=bar
bar='hello world'

arr=myarr
myarr=(a b c)

echo "get value in bar from foo: ${!foo}"

echo "myarr is ${myarr[@]}"
echo "the 0th element of arr is ${!arr[0]}"
