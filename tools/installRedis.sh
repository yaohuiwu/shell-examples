#!/bin/bash:

dft_ver=2.8.17
dft_site="http://download.redis.io/releases/"
dft_tar="redis-"$default_ver".tar.gz"
tar_ball=""

if [ $# -eq 0]
then
	wget "http://download.redis.io/releases/"$default_tar
	tar_ball="redis-"$default_ver".tar.gz
else
	
fi

