. ../hdfs-utils.sh


dfs.ls '/'

dfs.copyFromLocal hdfs-utils-test.sh '/'
dfs.copyToLocal /hdfs-utils-test.sh /tmp 
dfs.rmf /hdfs-utils-test.sh
