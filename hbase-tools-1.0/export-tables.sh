DIR="$( cd "$( dirname "$0"  )" && pwd  )"

. $DIR/hbase-utils.sh
. $DIR/hdfs-utils.sh

hbase.checkEnv

if [ $# -lt 1 ];then
   echo "namespace is required."
   echo "Usage: ./export-tables.sh [namespace]"
   exit 1
fi

ns=''
dfsDir=/export
output=$PWD
if [ $# -ge 1 ];then
   ns="$1"
   output="$PWD"
fi
if [ $# -ge 2 ];then
   output=$2
fi

nsLocal=$output/$ns
nsRemote=$dfsDir/$ns

# clean up
if [ $ns ];then
	dfs.rmfr $nsRemote
	if [ -e $nsLocal ];then
		echo "remove exist dir $nsLocal"
		 rm -rf $nsLocal
	fi
fi
mkdir -p $nsLocal 

hbase.getTableNames $ns "tables" 

for tb in ${tables}
do
	echo "exporting table: $tb"
	tbDir=$nsRemote/$tb
	tbName=$(hbase.tableName $ns $tb)
	hbase.exportTable $tbName $tbDir 
	dfs.copyToLocal $tbDir $nsLocal/$tb
done
