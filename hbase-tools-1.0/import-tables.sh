DIR="$( cd "$( dirname "$0"  )" && pwd  )"

. $DIR/hbase-utils.sh
. $DIR/hdfs-utils.sh

hbase.checkEnv

dfsDir=/import
input=$PWD

if [ $# -lt 1 ];then
    echo "Usage: ./import-tables.sh [local input dir]"
    exit 1
fi

input=$1

if [ ! -e $input -o ! -d $input ];then
    echo "$input not exists"
    exit 1
fi

# clean up
dfs.rmfr $dfsDir
dfs.mkdir $dfsDir

for ns in $(ls $input)
do
	nsLocal=$input/$ns
	nsRemote=$dfsDir/$ns
	dfs.copyFromLocal $nsLocal $dfsDir 
	echo "import namespace $ns"
	for tb in $(ls $nsLocal) 
	do
		echo "import table: $tb"
		tbName=$(hbase.tableName $ns $tb)
		hbase.importTable $tbName $nsRemote/$tb 
		echo "table $tb imported successfully."
	done
done
