#!/bin/bash

if [ $# -lt 2 ];then
	echo "Usage: ./add-admin.sh [email] [org_code] [host：可选，默认localhost] [comid: optional, default is 30000000]"
	exit 0
fi

email=$1
name=`expr match $email '\(.*\)@.*'`
org_code=$2

if [ $# -ge 3 ];then
	host=$3
else
	host="localhost"
fi
echo "connect to $host"

if [ $# -ge 4 ];then
	comid=$4
else
	comid=30000000
fi

mysql -h $host -u root -ppekall1234 <<EOF
	
	BEGIN;
	use mdm_reactor;

	INSERT INTO mdm_company_tenants_info (id, com_id, com_name, create_time, email, password, phone, roles, status, storage_size, update_time, username,org_code,org_name,creator) 
	VALUES ('$name', $comid, '$name', '2014-05-24 12:00:00', '$email', '?', '123456', 'role_id_aaaaaaaaaaaaaaaaaaaaaa02,role_id_aaaaaaaaaaaaaaaaaaaaaa03,role_id_aaaaaaaaaaaaaaaaaaaaaa04,role_id_aaaaaaaaaaaaaaaaaaaaaa05,role_id_aaaaaaaaaaaaaaaaaaaaaa06,role_id_aaaaaaaaaaaaaaaaaaaaaa07,role_id_aaaaaaaaaaaaaaaaaaaaaa08,role_id_aaaaaaaaaaaaaaaaaaaaaa09,role_id_aaaaaaaaaaaaaaaaaaaaaa10', 51001, 10485760, '2014-05-24 12:00:00', '$name','$org_code','$org_code','$name');

   INSERT INTO mdm_company_info ( id, app_no, com_id, com_name, create_time, dead_time, device_no, doc_no,email, ip_addr, login_time, max_device_no, open_up_time, phone, type, roles, status, update_time, user_no, username ) VALUES ( '$name', 0, $comid, '$name', now(), DATE_ADD(now(), INTERVAL 90 DAY), 0, 0, '$email', '', now(), 10000000, now(), '', '51011', 'role_id_aaaaaaaaaaaaaaaaaaaaaa02,role_id_aaaaaaaaaaaaaaaaaaaaaa03,role_id_aaaaaaaaaaaaaaaaaaaaaa04,role_id_aaaaaaaaaaaaaaaaaaaaaa05,role_id_aaaaaaaaaaaaaaaaaaaaaa06,role_id_aaaaaaaaaaaaaaaaaaaaaa07,role_id_aaaaaaaaaaaaaaaaaaaaaa08,role_id_aaaaaaaaaaaaaaaaaaaaaa09,role_id_aaaaaaaaaaaaaaaaaaaaaa10', '51020', NOW(), 0, '$email' );

   INSERT INTO mdm_auth_user (id, domain, password, status, username, name, org_code) VALUES ('$name', '$comid', 'x9Jq1zOsVDq4HRn6lhFumgl55OCCUIWWvrwtH4lSeq2oJORwbdxNhmfKRfI1GbdD', 51001, '1::$email','$name','$org_code');
	
	INSERT INTO mdm_auth_user_role VALUES 
	('${name}1', 'role_id_aaaaaaaaaaaaaaaaaaaaaa02', '$name'),
	('${name}2', 'role_id_aaaaaaaaaaaaaaaaaaaaaa03', '$name'),
	('${name}3', 'role_id_aaaaaaaaaaaaaaaaaaaaaa04', '$name'),
	('${name}4', 'role_id_aaaaaaaaaaaaaaaaaaaaaa05', '$name'),
	('${name}5', 'role_id_aaaaaaaaaaaaaaaaaaaaaa06', '$name'),
	('${name}6', 'role_id_aaaaaaaaaaaaaaaaaaaaaa08', '$name'),
	('${name}7', 'role_id_aaaaaaaaaaaaaaaaaaaaaa09', '$name'),
	('${name}8', 'role_id_aaaaaaaaaaaaaaaaaaaaaa20', '$name');

   commit;
EOF
echo "success"
#echo "IMPORTANT: SSH login to host where auth server installed , restart memcached service  using the following command:"
#echo "#service memcached restart"
exit 0;
