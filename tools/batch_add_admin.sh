#!/bin/bash

test_users=('admin-test-zjipst@pekall.com' 'admin-test-zjipst-1@pekall.com' 'admin-test-security@pekall.com' 'admin-test-security-policy@pekall.com' 'admin-test-security-reco@pekall.com')

org_codes=('330000000000' '330000000000' '330000010000' '330000012000' '330000012100')
total=${#test_users[@]}

host="localhost"
com_id="1"

echo "total user : $total"
echo "host :$host"
echo "com_id:$com_id"

idx=0
for i in ${test_users[@]}
do
	echo "$idx:${test_users[$idx]}:${org_codes[$idx]}"
	./add-admin.sh ${test_users[$idx]} ${org_codes[$idx]} $host $com_id
	let "idx=$idx+1"
done

#./add-admin.sh admin-test-zjipst@pekall.com 330000000000 localhost 1
#./add-admin.sh admin-test-zjipst-1@pekall.com 330000000000 localhost 1
#./add-admin.sh admin-test-security@pekall.com 330000010000 localhost 1
#./add-admin.sh admin-test-security-policy@pekall.com 330000012000 localhost 1
#./add-admin.sh admin-test-security-reco@pekall.com 330000012100 localhost 1
