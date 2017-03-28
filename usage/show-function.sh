#!/usr/bin/env bash

#Print all the arguement using $* or $@
f(){
    echo "total arguement is $#"
    echo `seq 1 $#`
    for arg in $@;do
        echo $arg
    done    
}

#Print the first arguement by indirect reference
firstArg(){
    firstArg=1
    echo "The first argument is ${!firstArg}"  
}

#Receve the return value by indirect reference
f2(){
   eval "${1}=hello";
}

f3(){
 return 100; 
}

f4(){
    v1="hello world"
    eval "${1}=\"$v1\""
}

# Put your test code here.

sq=`seq 1 3`

f $sq 
firstArg $sq

# Define a var to receive return value of f2
msg='a1'
f2 $msg

echo "hello msg is ${!msg}"
#clean up
unset $msg

echo "hello msg is ${!msg}. It should be empty now."

f3
echo $?

msg='a1'
f4 $msg

echo "f4:${!msg}"
echo "f4:${a1}"
unset a1
