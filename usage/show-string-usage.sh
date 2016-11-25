#!/usr/bin/env bash


str="Hello world"

#length
echo "length of $str is ${#str}"

#expr index (Mac doesn't support index)
#blkIndex=`expr index "$str" " "`
#echo "index of blank in $str is $blkIndex"


# subtring
echo "substring from 5 of $str is '${str:5}'"
echo "substring from 5 with length 2 of $str is '${str:5:2}'"

# the blank between : and - is mandatory
echo "substring from right side with length 5 of $str is '${str: -5}'"
echo "substring from right side with length 5 of $str is '${str:(-5)}'"

# delete string from beginning
echo "delete substring 'Hello' from beginning of  $str is '${str#Hello}'"
echo "delete substring 'world' from end of $str is '${str%world}'"

# replace string
echo "replace the first 'l' in $str with 'L' is '${str/l/L}'"
echo "replace all the 'l' in $str with 'L' is '${str//l/L}'"
echo "replace all the 'w*r' in $str with '***' is '${str//w*r/*}'"


