#!/bin/bash

echo "安装必须的依赖库..."
sudo apt-get install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev build-essential

echo "输入git版本号（默认2.1.0）:"
read gitV

${gitV:="2.1.0"}

gitD="git-$gitV"
gitF=$gitD".tar.gz"
if [ -e $gitD ] ; then 
	echo "目录${gitD}存在，略过编译"
else
	if [ -e $gitF ] ; then
		echo "找到文件$gitF"
	else
		echo "找不到文件$gitF"
		exit 0
	fi
	tar zxvf $gitF -C /tmp
fi

cd /tmp/$gitD
./configure
make 
sudo make install
git --verion

echo "输入全局用户名"
read globalUser
echo "输入默认邮箱"
read globalEmail
git config --global user.name "$globalUser"
git config --global user.email "$globalEmail"
git config --global push.default simple

echo "是否生成SSH Keys?[y/n]"
read createKeys
if [ $createKeys != 'y' ];then
	exit 0;
fi

if [ -e "~/.ssh" ] ; then 
	echo "是否删除$HOME/.ssh?[y/n]"
	read delSshDir
	if [ delSshDir != 'y'];then
		exit 0
	fi
fi

rm -rf "~/.ssh"
echo "生成ssh keys"
ssh-keygen -t rsa -C "$globalEmail"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

sudo apt-get install xclip
xclip -sel clip < ~/.ssh/id_rsa.pub
