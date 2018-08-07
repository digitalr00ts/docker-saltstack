[![Build Status](https://travis-ci.org/digitalr00ts/docker-saltstack.svg?branch=develop)](https://travis-ci.org/digitalr00ts/docker-saltstack)

# Saltstack Docker Container

This is my effort to run [SaltStack](https://saltstack.com/) masters in Docker containers. Published on [Docker Hub](https://hub.docker.com/r/digitalr00ts/saltstack/).

## Features

* Automated builds
* Available as Alpine or Ubuntu
* TLS for API enabled by default (self-signed cert generated if no cert found)
* Docker's in container process manager [tini](https://github.com/krallin/tini) baked in.

### Extra notes

* The images on the official [SaltStack repo](https://github.com/saltstack/docker-containers) are not well maintained.
* The base images, w/o SaltStack, are separated into their own [repo](https://github.com/digitalr00ts/docker-saltstack-base).

## Usage

### Run

```sh
docker run -d --name saltstack digitalr00ts/saltstack
```

### Build test

```sh
docker-compose -f .travis/compose-<distro>.yaml up -d --build
```

## Todos

* Better testing
* Change curl/wget url to use ARG for branch
* Ability to build Saltstack off commit
  * and point at any git url
* Better documentation
  * Usage / paths

## Notes / FAQ

### Layers - How is this container put together?

| Alpine | Ubuntu |
| ------ | ------ |
| [Upstream Alpine](https://hub.docker.com/_/alpine/) | [Upstream Ubuntu](https://hub.docker.com/_/ubuntu/) |
| [digitalr00ts Base](https://hub.docker.com/r/digitalr00ts/os/):alpine | [digitalr00ts Base](https://hub.docker.com/r/digitalr00ts/os/):ubuntu |
| [SaltStack Base](https://hub.docker.com/r/digitalr00ts/saltstack-base/):alpine | [SaltStack Base](https://hub.docker.com/r/digitalr00ts/saltstack-base/):ubuntu |
| [SaltStack](https://hub.docker.com/r/digitalr00ts/saltstack/):alpine | [SaltStack](https://hub.docker.com/r/digitalr00ts/saltstack/):ubuntu |

1. We start with the upstream OS container image
2. Then we have a small layer that is common to most digitar00ts containers to simplify infrastructure management.
3. After we create a layer of common dependencies for SaltStack, regardless of version.
4. Finally, the desired version of SaltStack is installed and any version dependant dependencies are installed.

### Why are there multiple services in one container?

There salt services are tightly coupled, based on both functionality and version. Therefore, we felt a monolithic container was appropriate here.

### Why do the e services run as root?

Salt requires root to access such things as PAM for authentication. While many best practices suggest to not run as root, we felt the loss in functionality was not worth the trade off. See https://docs.saltstack.com/en/latest/ref/configuration/nonroot.html

## License

LGPL-3.0-or-later


    This is free software: you can redistribute it and/or modify
    it under the terms of the Lesser GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.

    This is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    Lesser GNU General Public License for more details.

    You should have received a copy of the Lesser GNU General Public License
    along with Foobar.  If not, see <https://www.gnu.org/licenses/>.

Copyright 2017, 2018 digitalr00ts

## Anchor.io

* Alpine: [![Anchore Image Overview](https://anchore.io/service/badges/image/0eee9477226f99e9fd655776b93942ba9207b0b25ca56bee76cd104f698da231)](https://anchore.io/image/dockerhub/digitalr00ts%2Fsaltstack%3Alatest)
* Ubuntu: [![Anchore Image Overview](https://anchore.io/service/badges/image/2a7fb41b7529b11f238953c6eab4bce66da9382e8ad215b4c9552643d7ef5b49)](https://anchore.io/image/dockerhub/digitalr00ts%2Fsaltstack%3Aubuntu)
