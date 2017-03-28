
hbase="$HBASE_HOME/bin/hbase"

hbase.checkEnv(){
	if [ -z "$HBASE_HOME" -o ! -e "$HBASE_HOME" ];then
		echo "HBASE_HOME not found."
		exit 1
	fi
}

# get table names from hbase
#
# $1 : namsespace, optional, if not provided, empty namespace will be used.
# $2 : variable name that hold the result.
# $3 : use cache or not. 'True' or 'False'. default is 'False'
hbase.getTableNames(){
	ns="$1"
	echo "get table names for $ns"	
	tb_file="/tmp/${ns}_tables_cache.txt"
	useCache=${3-'False'}

	echo "using cache : $useCache"
	
	if [ 'True' = $useCache -a  -e $tb_file ];then
		echo "use cache from $tb_file"
	else
		echo "list_namespace_tables '${ns}'" | $hbase shell | sed -n '/TABLE/,/row/p' > $tb_file
	fi

	rows=`wc -l $tb_file | awk '{print $1}'`
	if [ $rows -gt 2 ];then
		let "rows=rows-1"
		let "tbCount=rows-1"
		echo "find ${tbCount} tables"
		tables=`sed -n '2,'"$rows"'p' $tb_file`

		eval "${2}=\"${tables}\""
	else
		eval "${2}=''"
	fi
}

# export table to a hdfs directory.
#
# $1 : table name
# $2 : hdfs directory
hbase.exportTable(){
	echo "export table $1 to directory $2"
	$hbase org.apache.hadoop.hbase.mapreduce.Export $1 $2
}

# export table to a hdfs directory.
#
# $1 : table name
# $2 : hdfs directory
hbase.importTable(){
	echo "import table $1 from directory $2"
	$hbase org.apache.hadoop.hbase.mapreduce.Import $1 $2
}

hbase.tableName(){
	if [ $1 -a $2 ];then	
		echo "$1:$2"
	else
		if [ $2 ];then
			echo "$2"
		fi
	fi
}

# $2 : use cahe or not. default is 'False'
hbase.truncateNamespace(){
	ns=$1
	cmdFile=".ns_tables.txt"
	echo "trunating namespace $ns"
	useCache=${2-'True'}
	if [ $ns ];then
		hbase.getTableNames $ns "tables" $useCache
		if [ "$tables" ];then
			for tb in "$tables"
			do
				echo "truncate '$ns:$tb'" >> $cmdFile
			done
		fi
		unset tables
		echo "exit" >> $cmdFile
		$hbase shell $cmdFile
		rm -rf $cmdFile
	fi
}
