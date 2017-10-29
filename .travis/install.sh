#!/usr/bin/env bash

set -ex
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release-cs) stable" > /etc/apt/sources.list.d/docker.list'
sudo apt-get update -o Dir::Etc::sourcelist=/etc/apt/sources.list.d/docker.list
sudo apt-get -y install docker-ce
sudo curl -fsSL https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname-s`-`uname -m` -o /usr/local/bin/docker-compose && \
  sudo chmod +x /usr/local/bin/docker-compose
docker version
docker-compose version
