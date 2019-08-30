#!/bin/sh
yum update

## Install docker
yum install -y --no-install-recommends \
    apt-transport-https \
    curl \
    software-properties-common
yum install -y --no-install-recommends \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual    
curl -fsSL 'https://sks-keyservers.net/pks/lookup?op=get&search=0xee6d536cf7dc86e2d7d56f59a178ac6c6238f52e' | sudo apt-key add -
add-apt-repository \
   "deb https://packages.docker.com/1.12/apt/repo/ \
   ubuntu-$(lsb_release -cs) \
   main"
yum update -y
yum -y install docker-engine
usermod -aG docker ubuntu
service docker start

##Install Git
yum install git -y