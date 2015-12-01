#!/bin/sh

#cvt 1920 1080
x=$1
y=$2
md_name="${x}x${y}_60.00"

mode=`cvt $x $y | sed -n '2p' | sed -n 's/Modeline//p'`
xrandr --newmode $mode
xrandr --addmode Virtual1 $md_name 
xrandr --output Virtual1 --mode $md_name
