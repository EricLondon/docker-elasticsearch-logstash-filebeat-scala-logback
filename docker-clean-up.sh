#!/usr/bin/env bash

docker-compose down
docker ps -a | grep Exited | awk '{print $1}' | xargs docker rm
docker volume rm elk_applogs elk_esdata
