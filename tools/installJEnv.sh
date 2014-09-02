#!/bin/bash
#安装java开发环境
#jdk1.7

ETC_PROFILE=/etc/profile
P_HOME=/usr/local/soft
echo "tar file dir:$Z_DIR"

if [ $# -eq 0 ] ; then 
	echo "用法: ./installJEnv.sh 压缩文件目录"
	echo "压缩文件在当前目录?"
	read use_current_dir
	if [ "y" == $use_current_dir ] ; then
		Z_DIR=$PWD
	else
		exit 0
	fi
else	
	Z_DIR=$1
fi

if [ ! -d $Z_DIR -o ! -e $Z_DIR ] ; then
	echo "文件 $Z_DIR 不是目录或不存在"
	exit 0
fi

if [ -e $P_HOME ] ; then
	echo "目录 $P_HOME 已存在，是否删除 ? y/n"
	read yes
	if [ $yes = "y"  ] ; then
		echo "删除目录$P_HOME"
   		sudo rm -rf $P_HOME
	else
		echo "请手动删除$P_HOME"
		exit 0
	fi
fi
JAVA_Z_FILE=$Z_DIR/jdk-7u45-linux-x64.tar.gz
JAVA_Z_DIR=jdk1.7.0_45

IDEA_Z_FILE=$Z_DIR/ideaIU-13.1.4b.tar.gz
IDEA_Z_DIR=idea-IU-135.1230

MYSQL_Z_FILE=mysql-5.6.20-linux-glibc2.5-x86_64.tar.gz
MYSQL_Z_DIR=mysql-5.6.20-linux-glibc2.5-x86_64

sudo mkdir -p $P_HOME
sudo chown -R $USER $P_HOME
sudo chgrp -R $USER $P_HOME

cd $P_HOME

echo "安装Jdk1.7"

JAVA_DIR=java
mkdir $JAVA_DIR
tar zxvf $JAVA_Z_FILE -C $JAVA_DIR
cd $JAVA_DIR
ln -s $JAVA_Z_DIR jdk

source $ETC_PROFILE
echo "JAVA_HOME=$JAVA_HOME"
sudo update-alternatives  --install  /usr/bin/java java $PWD/jdk/bin/java 300
sudo update-alternatives  --install  /usr/bin/javac javac $PWD/jdk/bin/javac 300
update-alternatives --config java
java -version

echo "安装Java成功"
cd ..

echo "开始安装IdeaIU"
IDEA_DIR=$PWD/ideaIU
mkdir ideaIU
cd ideaIU
tar zxvf $IDEA_Z_FILE -C $PWD
ln -s $IDEA_Z_DIR idea
IDEA_HOME=$IDEA_DIR/idea

source $ETC_PROFILE
echo "安装idea成功"
cd ..

echo "开始安装maven"
mkdir maven
cd maven
tar zxvf $Z_DIR/apache-maven-3.2.1-bin.tar.gz -C $PWD
ln -s apache-maven-3.2.1 mvn

sudo sed -i -e '/JAVA_HOME/d; /M2_HOME/d; /IDEA_HOME/d'  $ETC_PROFILE
sudo sed -i '$ a\export JAVA_HOME=/usr/local/soft/java/jdk \
export CLASSPATH=.:$JAVA_HOME/lib/tools.jar \
export IDEA_HOME=/usr/local/soft/ideaIU/idea \
export M2_HOME=/usr/local/soft/maven/mvn \
export PATH=$JAVA_HOME/bin:$IDEA_HOME/bin:$M2_HOME/bin:$PATH' $ETC_PROFILE

sudo update-alternatives  --install  /usr/bin/mvn mvn $P_HOME/maven/mvn/bin/mvn 301

source $ETC_PROFILE
mvn -version

echo "Maven 安装成功"
cd ..
