. ../hbase-utils.sh

./init-test-tables.sh
./init-test-data.sh

ns='test'
ns_export="${ns}-export"

../export-tables.sh $ns $ns_export


if [ $? -eq 0 ];then
	hbase.truncateNamespace $ns
fi

../import-tables.sh $ns_export 
