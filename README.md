[![Build Status](https://travis-ci.org/digitalr00ts/docker-saltstack.svg?branch=dev)](https://travis-ci.org/digitalr00ts/docker-saltstack)<br/>

# Saltstack Docker Container

This is my effort to run Salt masters in Docker containers.

## Why not saltstack/docker-containers

* The images on the official [SaltStack repo](https://github.com/saltstack/docker-containers) are not well maintained.
* There new and better ways manage service(s) within a container, i.e. [tini](https://github.com/krallin/tini).
* The base images, w/o SaltStack, are separated into their own [repo](https://github.com/digitalr00ts/docker-saltstack-base).

## Todos

* Better testing
* Run salt service as not root
* Move
  * `/etc/salt/master.d` to `/opt/salt/master.d`
  * `/etc/salt/pki/` to `/opt/salt/pki/`
* Add volumes to docker-compose
* docker-compose for Alpine
* Merge dev to master if test pass
* Move docker hub to watch master

## Anchor.io

* Alpine: [![Anchore Image Overview](https://anchore.io/service/badges/image/0eee9477226f99e9fd655776b93942ba9207b0b25ca56bee76cd104f698da231)](https://anchore.io/image/dockerhub/0eee9477226f99e9fd655776b93942ba9207b0b25ca56bee76cd104f698da231?repo=digitalr00ts%2Fsaltstack&tag=latest)
* Ubuntu: [![Anchore Image Overview](https://anchore.io/service/badges/image/2a7fb41b7529b11f238953c6eab4bce66da9382e8ad215b4c9552643d7ef5b49)](https://anchore.io/image/dockerhub/2a7fb41b7529b11f238953c6eab4bce66da9382e8ad215b4c9552643d7ef5b49?repo=digitalr00ts%2Fsaltstack&tag=ubuntu)
