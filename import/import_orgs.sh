#!/bin/sh

#输入文件格式: 标准csv文件,且按照先祖先,后子孙的顺序
#依赖存储过程: create_org_new

if [ $# -lt 3 ];then
	echo "用法: ./import_orgs.sh 文件名 com_id host [true/false:是否清除后代机构]"
	exit 0
fi

db_user='root'
db_pwd='pekall1234'
db_host='localhost'
if [ $3 != '' ];then
	db_host=$3
fi
db_port=3306

echo "清除除顶级机构之外的机构,机构树数据..."
mysql -u $db_user -p$db_pwd -h $db_host -P $db_port -D mdm_reactor -e "call del_org_descendants('京联云', '30000000', false);"

org_sql=`awk -F ',' '
BEGIN{
	i=0
	sql=""
}
{
	if(NR > 1 && $3 != "") {
		#printf("%d\t%s\t%s\t%s\n", i, $1, $2, $3)
		#i++
		sql=sql"call create_org_new('\''" $1 "'\'','\''" $2 "'\'','\''" $3 "'\'','\''30000000'\'');"
	}
}
END{
	print sql
}' $1`

echo "executing..$org_sql"
mysql -u $db_user -p$db_pwd -h $db_host -P $db_port -D mdm_reactor -e "$org_sql"
