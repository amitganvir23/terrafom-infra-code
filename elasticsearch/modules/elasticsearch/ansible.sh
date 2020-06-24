#!/bin/sh

# elasticsearch_plybook="../../../ansible/test/cp-ansible/"
elasticsearch_plybook="../../../ansible-code/elasticsearch/"
sleep 2m 
sudo find  $elasticsearch_plybook -type f|xargs dos2unix
sudo chmod 655 $elasticsearch_plybook/hosts/*
sleep 1m
sudo $elasticsearch_plybook/hosts/ec2.py --list --refresh
cd $elasticsearch_plybook
#sudo ansible-playbook elasticsearch-inv-create.yml -i hosts/ec2.py
#sleep 40
#ansible-playbook all.yml -i hosts/elasticsearch_inventory > /tmp/elasticsearch-ansible.log
#ansible-playbook elasticsearch_hosts.yml elasticsearch-deploy.yml -i hosts/ec2.py --private-key /tmp/sai-ec2.pem >> /tmp/elasticsearch-ansible.log
