#!/bin/bash

if [ $# -lt 1 ];then
	echo "Usage: ./ssh_nologin.sh [远程主机ip]"
	exit 0
fi
remote_host=$1
sshdir=~/.ssh
encript_type="rsa"

rsa_file=$sshdir/$encript_type"_"$remote_host
rsa_pub=$rsa_file".pub"
if [ -e $rsa_file ];then
	rm -f $rsa_file
fi
if [ -e $rsa_pub ];then
	rm -f $rsa_pub
fi
ssh-keygen -t $encript_type -f $rsa_file
#eval "$(ssh-agent -s)"
#ssh-add $rsa_file

cat $rsa_pub
