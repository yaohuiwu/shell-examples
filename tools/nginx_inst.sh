#!/bin/bash
#安装nginx
if [ $# -eq 0 ];then
	echo "用法：nginx_inst.sh nginx文件地址（可下载的http，ftp或本地文件）"
	exit 0
fi
[ $1 ] && NGX_LOC=$1 || NGX_LOC=nginx-1.6.1.tar.gz
NGX_F=`expr match $1 '.*\(nginx.*tar.gz\)'`
IS_HTTP=`expr match "$NGX_LOC" ^http://.*$`

cd /tmp

if [ $IS_HTTP ];then
	if [ -e $NGX_F ] ; then
		echo "删除文件$NGX_F"
		rm $NGX_F
	fi
	wget $NGX_LOC
fi
