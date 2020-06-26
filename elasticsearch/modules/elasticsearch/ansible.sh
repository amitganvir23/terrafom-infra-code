#!/bin/sh

## "elasticsearch_ec2_tag" variable value is coming from terraform
elasticsearch_ec2_tag=$elasticsearch_ec2_tag
elasticsearch_plybook="../../ansible-code/elasticsearch/"

sleep 2m
cd $elasticsearch_plybook
if [ $? -eq 0 ]
then
  sudo find  . -type f | xargs dos2unix
  sudo chmod 655 hosts/*
  sudo hosts/ec2.py --list --refresh
  sleep 1m
  ansible-playbook -i hosts/ec2.py elasticsearch.yml -e "elasticsearch_ec2_tag=$elasticsearch_ec2_tag"
else
  echo "Error, Dir dose not exisit $elasticsearch_plybook"
fi