

apt-get -y update
apt-get -y install jq
apt-get -y install python

# curl -O https://bootstrap.pypa.io/get-pip.py
# export PATH=~/.local/bin:$PATH
# python get-pip.py --user
# pip install awscli --upgrade --user
##OR
apt install python-pip -y


pip install boto
pip install boto3
pip install ansible --upgrade

sudo apt -y install openjdk-8-jdk
apt install awscli -y

/usr/lib/jvm/java-8-openjdk-amd64

cat /etc/profile
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
PATH=$PATH:$HOME/bin:$JAVA_HOME/bin
export JAVA_HOME
export JRE_HOME
export PATH

======================
root@ip-172-31-85-157:~# java -version
openjdk version "1.8.0_242"
OpenJDK Runtime Environment (build 1.8.0_242-8u242-b08-0ubuntu3~18.04-b08)
OpenJDK 64-Bit Server VM (build 25.242-b08, mixed mode)
root@ip-172-31-85-157:~#

