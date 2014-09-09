#!/bin/bash
#GNU软件的安装脚本
VERSION=1.0
if [ $# -lt 1 ];then
	echo "用法：gnuinst.sh 压缩文件"
	echo "版本: $VERSION"
	echo '说明：其中压缩文件可以是本地，http，ftp。
    格式为tar.gz,tar.xz'
	exit 0
fi
_LOC=$1
_F=`expr match $_LOC '.*/\(.*.tar.[gx]z\)'`
_D=`expr match $_F '\(.*\).tar.[gx]z'`
echo $_LOC
is_ftp=`expr match $_LOC 'ftp://.*'`
is_http=`expr match $_LOC 'http[s]\{0,1\}://.*'`


#echo $_F
#echo $_D
#echo $is_ftp
#echo $is_http
cd /tmp

if [ $is_ftp -gt 0 -o  $is_http -gt 0 ];then
	if [ -e $_F ] ; then
		echo "文件$_F已存在"
	else
		wget $_LOC
	fi
fi
if [ -e $_D ];then
	echo "目录$_D 已存在，是否删除？[y/n]"
	read delD
	if [ 'y' == $delD ];then
		echo "删除目录$_D"
		rm -r $_D
	fi
fi
GZ=`expr match $_F '.*.gz'`
XZ=`expr match $_F '.*.xz'`

#解 压
if [ $GZ -gt 0  ];then
	tar zxvf $_F
elif [ $XZ -gt 0 ];then
	rm -f $_D".tar"
	xz -d $_F
	tar xvf $_D".tar"
	rm -f $_D".tar"
else
	echo "不能识别压缩文件格式"
	exit 0
fi

cd $_D
./configure
make
sudo make install
echo "删除$_D"
rm -rf $_D
cd /tmp
