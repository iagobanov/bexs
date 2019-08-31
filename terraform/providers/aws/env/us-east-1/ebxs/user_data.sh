#!/bin/sh
yum update -y

## Install docker
yum install amazon-linux-extras -y 
yum install docker -y
service docker start
usermod -a -G docker ec2-user


## Install Docker-compose
curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
sleep 5

##Install Git
yum install git -y

## Clone repo
git clone https://github.com/iagobanov/bexs.git

## Start application
cd bexs && docker-compose up &