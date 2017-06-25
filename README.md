# Saltstack Docker Container

This is my effort to run Salt masters in Docker containers.

Usage:

```bash
git clone <repo>
docker build --no-cache --file Dockerfile --tag saltstack:2016.11.6 --tag saltstack:latest <repo_dir>
<repo_dir>/docker-run.sh 2016.11.6
```

## Caveats

This may be added later or in a different build

* No REAT support

# To Dos

* Have Salt run as not root user
* Ability to add user during `docker run`
