#!/bin/bash

test_users=('admin-test-zjipst@pekall.com' 'admin-test-zjipst-1@pekall.com' 'admin-test-security@pekall.com' 'admin-test-security-policy@pekall.com' 'admin-test-security-reco@pekall.com')

host="localhost"

for i in ${test_users[@]}
do
	echo "deleting $i at $host"
	./del-admin.sh $i $host
	echo ""
done

#./del-admin.sh admin-test-zjipst@pekall.com localhost
#./del-admin.sh admin-test-zjipst-1@pekall.com localhost
#./del-admin.sh admin-test-security@pekall.com localhost
#./del-admin.sh admin-test-security-policy@pekall.com localhost
#./del-admin.sh admin-test-security-reco@pekall.com localhost
