#!/bin/bash
echo "安装pcre"

cd /lib/x86_64-linux-gnu
if [ -e libpcre.so.3.13.1 ];then
	if [ -e pcre.so.1 ];then
		sudo ln -s libpcre.so.3.13.1 pcre.so.1
	fi
	echo "pcre已安装，略过"
else	
	./gnuinst.sh ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.35.tar.gz
fi
cd $OLDPWD

echo "安装nginx"
NGX_D=/usr/local/nginx
running=`ps -aux |  awk '{if($14 ~ /sbin\/nginx/ ) print $14}'`
if [ $running ];then
	echo "nginx 正在运行"
	ps aux | grep nginx
	echo "是否关闭y/n"
	read shutd
	if [ $shutd ];then
		sudo $NGX_D/sbin/nginx -s stop
		exit 0
	else
		exit 0
	fi
fi
if [ -e $NGX_D ]; then
	echo "目录$NGX_D 已存在，是否覆盖安装[y/n]"
	read overwrite
	if [ 'y' == $overwrite ] ; then
		echo "删除目录$NGX_D"
		sudo rm -rf $NGX_D
	else
		exit 0
	fi
fi
./gnuinst.sh http://nginx.org/download/nginx-1.6.1.tar.gz
