#!/bin/bash

set -x

docker stop $(docker ps -q)
docker compose down --remove-orphans -v
docker rm $(docker ps -a -q)
docker compose down --remove-orphans -v
docker volume prune -a
sudo rm -rf /data/*
