#!/usr/bin/env bash

#Print all the arguement using $* or $@
f(){
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
