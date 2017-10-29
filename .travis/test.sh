#!/usr/bin/env bash

set -ex

#BUILD
docker-compose -f .travis/compose-${distro}.yaml build --no-cache --pull
docker-compose -f .travis/compose-${distro}.yaml up -d
docker-compose -f .travis/compose-${distro}.yaml ps && sleep 3

#TEST
docker-compose -f .travis/compose-${distro}.yaml exec saltmaster sh -c 'salt-call --master=$(hostname) test.ping || salt-key --accept=$(hostname) --yes'
docker-compose -f .travis/compose-${distro}.yaml exec saltmaster sh -c 'salt-call --master=$(hostname) test.ping'
docker-compose -f .travis/compose-${distro}.yaml exec saltmaster sh -c '[ $(salt-call --master=$(hostname) grains.get --output=newline_values_only nodename) = $(hostname) ]'
curl -vk https://localhost:8000
