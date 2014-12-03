#!/bin/bash

a=""
echo $a
i=0
while [ $i -lt 10 ]
do
	a=$a":"$i

  	let "i=i+1"
done

echo $a
