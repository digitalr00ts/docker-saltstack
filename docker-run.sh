#!/bin/bash

docker rm -f saltstack
docker run -d --name saltstack \
	$([ -z "$2" ] || echo "-h $2") \
	-p 4505:4505 -p 4506:4506 -p 8000:8000 \
	-v $(pwd)/salt:/srv/salt \
	-v $(pwd)/config:/opt/salt \
	-v $(pwd)/logs:/opt/log \
	-v $(pwd)/extras:/opt/extras \
	saltstack:${1:-latest}
