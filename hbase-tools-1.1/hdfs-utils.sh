
dfs="$HADOOP_HOME/bin/hdfs dfs"

dfs.checkHome(){
	if [ -z "$HADOOP_HOME" -o ! -e "$HADOOP_HOME" ];then
		echo "HADOOP_HOME not found."
		exit 1
	fi
}

dfs.ls(){
	$dfs -ls $1
}

# copy a file or directory to local file system.
#
# $1 : source file or directory.
# $2 : local file or directory.
dfs.copyToLocal(){
	 $dfs -copyToLocal $1 $2
}

# copy local file to hdfs
#
# $1 : local file
# $2 : hdfs directory
dfs.copyFromLocal(){
	$dfs -copyFromLocal $1 $2
}

dfs.rm(){
	$dfs -rm $1
}

dfs.rmf(){
	$dfs -rm -f $1
}

dfs.rmfr(){
	$dfs -rm -f -r $1
}

dfs.mkdir(){
	$dfs -mkdir -p $1
}
