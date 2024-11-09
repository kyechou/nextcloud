#!/bin/bash

set -x

mapfile -t containers < <(docker ps --filter name=nextcloud-aio -q)
docker stop "${containers[@]}"
docker compose down --remove-orphans -v

mapfile -t containers < <(docker ps -a --filter name=nextcloud-aio -q)
docker rm "${containers[@]}"
docker compose down --remove-orphans -v

docker volume prune -a
sudo rm -rf /data/nextcloud
