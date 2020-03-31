#!/bin/sh

sudo cat > /etc/sysconfig/network-scripts/ifcfg-eth1 <<EOF
BOOTPROTO=dhcp
DEVICE=eth1
ONBOOT=yes
TYPE=Ethernet
USERCTL=no
DEFROUTE=no
EOF
sudo /usr/sbin/ifdown eth1
sudo /usr/sbin/ifup eth1


array=(nvme1n1
)
array2=(/data01
)

   for index in ${!array[*]}; do
        sudo mkfs -t ext4 /dev/${array[$index]}
   done

   for index in ${!array[*]}; do
        sudo mkdir -p ${array2[$index]}
        sudo mount -o defaults,noatime /dev/${array[$index]} ${array2[$index]}
        sudo echo "/dev/${array[$index]} ${array2[$index]} ext4 defaults,noatime 0 0" >> /etc/fstab
        sudo useradd nifi
        sudo chown nifi:nifi -R ${array2[$index]}
   done
