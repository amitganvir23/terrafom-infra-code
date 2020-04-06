#!/bin/bash

for i in $(cat nodes.txt)
do 
ssh -i event-tracker.pem ec2-user@$i <<EOF
sudo yum install wget rpm which unzip java -y 
EOF
done
