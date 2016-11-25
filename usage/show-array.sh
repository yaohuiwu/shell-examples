#!/usr/bin/env bash


arr=(a b c d e)
arr1=(f g)

echo "print arr:"
for e in "${arr[*]}"
do
    echo $e
done

index=0

echo "length of arr is ${#arr[@]}"
echo "first element of arr is ${arr[0]}"
echo "second element of arr is ${arr[$index+1]}"

arr2=(${arr[@]} ${arr1[@]})

echo "combine arr with arr1 is ${arr2[@]}"
