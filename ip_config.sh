#!/bin/bash

if [ $# -lt 3 ];then
    echo "Usage:./ip_config.sh [ipaddress] [netmask] [gateway]"
    exit 0
fi

ip_static=$1
netmask=$2
gateway=$3

sys_cfg=/etc/sysconfig
if_file=$sys_cfg/network-scripts/ifcfg-eth0
network_file=$sys_cfg/network
dns_file=/etc/resolv.conf

echo "configing static ip..."
sed -i -e '/IPADDR/d; /NETMASK/d' $if_file
sed -i "\$a\\IPADDR=${ip_static}" $if_file
sed -i "\$a\\NETMASK=${netmask}" $if_file

#cat $if_file
sed -i -e 's/ONBOOT=no/ONBOOT=yes/g; s/BOOTPROTO=dhcp/BOOTPROTO=static/g;' $if_file

echo "configing gateway..."
sed -i -e '/GATEWAY/d' $network_file
sed -i "\$a\\GATEWAY=${gateway}" $network_file
#cat $network_file

echo "Dns configuration is not support currently , please add 'nameserver *.*.*.*' to file $dns_file."
#echo $dns1
#sed -i -e '/nameserver/d' $dns_file
#sed -i "\$a\\nameserver ${dns1}" $dns_file
#if [ $# -ge 5 ];then
#    sed -i "\$a\\nameserver ${dns2}" $dns_file
#fi
#cat $dns_file

service network restart
echo "compelete!"
