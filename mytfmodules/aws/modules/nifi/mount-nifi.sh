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
       nvme2n1
        nvme3n1
        nvme4n1
        nvme5n1
        nvme6n1
        nvme7n1
)
array2=(/data01/nifi/provenance_repo
        /data02/nifi/flowfile_repo
	    /data03/nifi/cont_repo
	    /data04/nifi/database_repo
	    /data05/nifi/conf
	    /var/log/nifi
	    /user_app_logs
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
