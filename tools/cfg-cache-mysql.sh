#!/bin/bash

my_cnf=/etc/my.cnf
if [ ! -e $my_cnf ];then
	echo "$my_cnf not exits."
	exit 0
fi

cache_size=`free -o -m | awk '{if($1 ~ /Mem:/ ) print $2}'`
let "cache_size=$cache_size/10"
echo $cache_size

#清除之前的配置
sed -i -e '/innodb_buffer_pool_size/d; /query_cache_limit/d; /query_cache_size/d; /query_cache_type/d;' $my_cnf

sed -i "/\[mysqld\]/ a\\innodb_buffer_pool_size=${cache_size}M" $my_cnf
sed -i "/\[mysqld\]/ a\\query_cache_limit=52M" $my_cnf
sed -i "/\[mysqld\]/ a\\query_cache_size=52M" $my_cnf
sed -i "/\[mysqld\]/ a\\query_cache_type=ON" $my_cnf

cat $my_cnf
service mysql.server status
echo "重启mysql..."
service mysql.server restart

