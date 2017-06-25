#!/bin/bash

docker run -d --name saltstack -p 4505:4505 -p 4506:4506 -p 8000:8000 -v $(pwd)/salt:/srv/salt -v $(pwd)/config:/opt/salt -v $(pwd)/logs:/opt/log saltstack:${1:-latest}
