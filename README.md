# Saltstack Docker Container

This is my effort to run Salt masters in Docker containers.

## Why not saltstack/docker-containers

* The images on the official [SaltStack repo](https://github.com/saltstack/docker-containers) are not well maintained.
* There new and better ways manage service(s) within a container, i.e. [tini](https://github.com/krallin/tini).
* The base images, w/o SaltStack, are separated into their own [repo](https://github.com/digitalr00ts/docker-saltstack-base).
