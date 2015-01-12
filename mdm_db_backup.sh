#! /bin/sh

if [ $# -lt 1 ];then
    echo "Usage: ./mdm_db_backup.sh mysql_host_ip"
    exit 0
fi

mysql_host_ip=$1

datetime=`date "+%Y-%m-%d_%H-%M-%S"`
backup_dir="/apps/pekall/db_backup/"
backup_file="mdm.sql.$datetime.gz"

echo Backup mysql $mysql_host_ip ...

mkdir -p $backup_dir
mysqldump -h $mysql_host_ip -uroot -ppekall1234 -R mdm_reactor | gzip > "$backup_dir$backup_file"

echo Backup done! Backup file is "$backup_dir$backup_file"
