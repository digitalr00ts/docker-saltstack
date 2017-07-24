# Saltstack Docker Container

This is my effort to run Salt masters in Docker containers.

Usage:

```bash
git clone <repo>

# Alpine
docker build --no-cache --file alpine/Dockerfile --tag saltstack-alpine:2016.11.6 --tag saltstack-alpine:latest <repo_dir>
<repo_dir>/alpine/docker-run.sh 2016.11.6

#Ubuntu
docker build --no-cache --file ubuntu/Dockerfile -e SALT_VER='2016.11.6' --tag saltstack-ubuntu:2016.11.6 <repo_dir>
docker build --no-cache --file ubuntu/Dockerfile --tag saltstack-ubuntu:latest <repo_dir>
docker run --detached saltstack-ubuntu
```

# To Dos

* Have Salt run as not root user
* Log rotation
