#!/bin/bash
usage="用法: （以root用户执行）\
	sudo ./installMysql.sh [/path/to/mysql.tar.gz]"
if [ $# -eq 0 ];then
	echo $usage
	exit 0;
fi
echo "mysql tar file :$1"

_F=`expr match $1 '.*/\(.*.tar.[gx]z\)'`
_D=`expr match $_F '\(.*\).tar.[gx]z'`
echo "dir of mysql after unzip:$_D"

VERSION=5.6.20
OS=linux-glibc2.5-x86_64

mysql_home=/usr/local/soft/mysql/mysql
normal_home=/usr/local/mysql

normal_admin=$normal_home/bin/mysqladmin
bin_mysqladmin=$mysql_home/bin/mysqladmin

if [ `ps -aux |  awk '{if($11 ~ /mysqld/ ) print $11}'` ] ; then 
	echo "mysql 正在运行, 是否关闭mysql?[Y/n]"
	read closeMysql
	if [ $closeMysql = 'Y' ]; then
		if [ -e $normal_admin ];then
			$normal_admin -u root -p shutdown
			echo "mysql已关闭"
		else
			if [ -e $bin_mysqladmin ];then
				$bin_mysqladmin -u root -p shutdown
				echo "mysql已关闭"
			else
				echo "找不到mysqladmin，请手动停止mysql。"
				exit 0
			fi
		fi
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
	sudo rm -rf ./mysql 
fi 

mkdir mysql

###################官方文档的安装步骤#################
cd mysql
echo "正在解压..."
tar zxf $1 -C $PWD
ln -s $_D mysql
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
basedir=/usr/local/soft/mysql/mysql \
lower_case_table_names=1 	\
character-set-server=utf8 	\
collation-server=utf8_general_ci' my.cnf

sed	-i '$ a\[client] \
default_character_set=utf8' my.cnf

#bin/mysqld_safe --user=mysql &

if [ -e /etc/init.d/mysql.server ]; then
	echo "删除/etc/init.d/mysql.server"
	rm -rf /etc/init.d/mysql.server
fi
# Next command is optional
if [ -e /etc/my.cnf ];then
	echo "删除/etc/my.cnf"
	rm -rf /etc/my.cnf
fi
cp my.cnf /etc
cp support-files/mysql.server /etc/init.d/mysql.server

#删除服务
update-rc.d -f mysql.server remove
#注册为服务
update-rc.d -f mysql.server defaults
######################################################

#sudo /etc/init.d/mysql.server start
#sudo /etc/init.d/mysql.server status
service mysql.server start
service mysql.server status

echo "Do you want to config security of mysql ? [y/n]"
read is_ensure_security
if [ $is_ensure_security = 'y' ];then
	bin/mysql_secure_installation
fi

bin_mysql=bin/mysql

echo "是否设置root远程访问?[Y/n]"
read is_root_access_remote
if [ $is_root_access_remote = 'Y' ];then
	echo "请输入root远程访问密码："
	read root_password
	$bin_mysql -u root -p$root_password -e "GRANT ALL PRIVILEGES ON *.* TO root@'%' IDENTIFIED BY '"$root_password"';flush PRIVILEGES;"
fi
echo "安装成功"
echo "mysql is successfully intalled at $mysql_home."
ver=`bin/mysql --version`
echo $ver
