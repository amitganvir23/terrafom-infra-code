#!/bin/sh

elasticsearch_plybook="../../../ansible-code/elasticsearch/"
sleep 2m
cd $elasticsearch_plybook
sudo find  . -type f|xargs dos2unix
sudo chmod 655 hosts/*
sudo hosts/ec2.py --list --refresh
#sudo ansible-playbook elasticsearch-inv-create.yml -i hosts/ec2.py
sleep 1m
#ansible-playbook all.yml -i hosts/elasticsearch_inventory > /tmp/elasticsearch-ansible.log
#ansible-playbook elasticsearch_hosts.yml elasticsearch-deploy.yml -i hosts/ec2.py --private-key /tmp/sai-ec2.pem >> /tmp/elasticsearch-ansible.log
ansible-playbook -i hosts/ec2.py elasticsearch.yml