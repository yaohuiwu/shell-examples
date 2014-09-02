#!/bin/bash
usage="用法: （以root用户执行）\
	sudo ./installMysql.sh [压缩包位置]"
if [ $# -eq 0 ];then
	echo $usage
	exit 0;
fi
echo "压缩文件位置$1"

VERSION=5.6.20
OS=linux-glibc2.5-x86_64

mysql_home=/usr/local/soft/mysql/mysql

if [ `ps -aux |  awk '{if($11 ~ /mysqld/ ) print $11}'` ] ; then 
	echo "mysql 正在运行, 是否关闭mysql?[y/n]"
	read closeMysql
	if [ $closeMysql = 'y' ]; then
		$mysql_home/bin/mysqladmin -u root -p shutdown
		echo "mysql已关闭"
	else
		exit 0
	fi
fi

apt-get install libaio1

if [ -z `cat /etc/group | awk -F: '{if($1 ~ /mysql/) print $1}'` ] ; then
	groupadd mysql
else
	echo "用户组mysql已存在"
fi

if [ -z  `cat /etc/passwd | awk -F: '{if($1 ~ /mysql/) print $1}'` ] ; then
	useradd -r -g mysql mysql
else
	echo "用户mysql已存在"
fi


cd /usr/local/soft
if [ -e "mysql" ] ; then
	echo "删除$PWD/mysql"
	rm -rf ./mysql 
fi 

mkdir mysql

###################官方文档的安装步骤#################
cd mysql
echo "正在解压..."
tar zxf $1/mysql-$VERSION-$OS.tar.gz
ln -s mysql-$VERSION-$OS mysql
cd mysql
chown -R mysql .
chgrp -R mysql .
scripts/mysql_install_db --user=mysql
chown -R root .
chown -R mysql data

echo "配置my.cnf"
if [ ! -e my.cnf ] ; then 
	echo "my.cnf不存在"
	exit 0
fi
sed -i '/\[mysqld\]/ a\bind-address=0.0.0.0 \
lower_case_table_names=1 	\
character-set-server=utf8 	\
collation-server=utf8_general_ci' my.cnf

sed	-i '$ a\[client]           	\
default-charactor-set=utf8' my.cnf

bin/mysqld_safe --user=mysql &

if [ -e /etc/init.d/mysql.server ]; then
	echo "删除/etc/init.d/mysql.server"
	rm -rf /etc/init.d/mysql.server
fi
# Next command is optional
cp support-files/mysql.server /etc/init.d/mysql.server
######################################################

echo "安装成功"
