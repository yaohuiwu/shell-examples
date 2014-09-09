#!/bin/bash
#使用wget下载download.list中的文件

[ $1 -a -e $1 ] && LIST_F=$1 || LIST_F=download.list
[ $2 -a -e $2 -a -d $2 ] && LIST_D=$2 || LIST_D=$PWD

while linestr=$(line)
do
	echo "$linestr"
	wget -P $LIST_D  $linestr
done < $LIST_F

echo "下载完毕。"
