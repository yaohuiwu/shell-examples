#!/bin/bash
#安装nginx
if [ $# -eq 0 ];then
	echo "用法：nginx_inst.sh nginx文件地址（可下载的http，ftp或本地文件）"
	exit 0
fi
[ $1 ] && NGX_LOC=$1 || NGX_LOC=nginx-1.6.1.tar.gz
NGX_F=`expr match $1 '.*\(nginx.*tar.gz\)'`
NGX_D=`expr match $NGX_F '(.*).tar.gz'`
IS_HTTP=`expr match "$NGX_LOC" ^http://.*$`

cd /tmp

if [ $IS_HTTP ];then
	if [ -e $NGX_F ] ; then
		echo "文件$NGX_F已存在"
	else
		wget $NGX_LOC
	fi
fi
GZ=`expr match "$NGX_F" '.*gz'`
#XZ=`expr match "$NGX_F" '.*xz'`

#i解 压
if [ $GZ  ];then
	tar zxvf $NGX_F
#elif [ $XZ ];then
#	tar xvJf $NGX_F
#else
#	echo "不能识别压缩文件格式"
fi
cd $NGX_D
./configure
make
sudo make install
