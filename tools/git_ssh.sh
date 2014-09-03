#!/bin/bash
#配置多服务器的git ssh环境

sshdir=~/.ssh
encript_type="rsa"

#echo "输入生成的公钥文件名（id_rsa_*）："
#read rsa_private
echo "输入git服务器的主机名或IP："
read git_host

rsa_file=$sshdir/$encript_type"_"$git_host

ssh-keygen -t $encript_type -f $rsa_file
#eval "$(ssh-agent -s)"
ssh-add $rsa_file


ssh_config=$sshdir/config

if [ ! -e $ssh_config ] 
then 
	touch $ssh_config	
fi

sed -i "\$ a\\Host $git_host \
	HostName $git_host \
	User	git \
	PreferredAuthentications publickey \
	IdentitiesOnly yes \
	IdentityFile $rsa_file" $ssh_config

cat $rsa_file".pub"

echo "是否初始化第一个git项目[y/n]："
read initFirstProj
if [ 'y' = $initFirstProj ]
then
	echo "输入项目目录："
	read initDir
	echo "输入项目地址："
	read remoteUrl
	
	cd $initDir
	git clone $remoteUrl
fi
