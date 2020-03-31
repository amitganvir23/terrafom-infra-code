#!/bin/sh

ALL_DISKS=`lsblk --noheadings --raw -o NAME,MOUNTPOINT | grep -v nvme0`

   COUNTER=1
   for disk in $ALL_DISKS; do
   	sudo mkfs -t ext4 /dev/$disk
   	sudo mkdir /data$COUNTER
   	sudo mount -o defaults,noatime /dev/$disk /data$COUNTER
   	echo "/dev/$disk /data$COUNTER ext4 defaults,noatime 0 0" >> /etc/fstab
   	COUNTER=$(($COUNTER+1))
   done