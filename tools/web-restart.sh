#!/bin/sh

echo $PWD

port=8080
if [ $# -gt 0 ]
then
	port=$1
fi

echo "Checking port:$port"
pid_n=`netstat -anp | grep ":::"$port | awk '{print substr($7,0,index($7,"/"));}'`
#echo $pid_n

if [ $pid_n ]
then
	echo "Killing process(PID:$pid_n) bound to 8080..."
	kill -9 $pid_n
else
	echo "No process bound to $port."
fi

cd .. && mvn install && cd $OLDPWD
mvn jetty:run
