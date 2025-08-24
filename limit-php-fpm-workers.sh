#!/bin/bash

set -x

name=nextcloud-aio-nextcloud
file_name=/usr/local/etc/php-fpm.d/www.conf
max_workers=7
is_running="$(docker container inspect "$name" | jq -r '.[0].State.Running')"

if [[ "$is_running" == "true" ]]; then
    sudo docker exec -it "$name" \
        sed -i -e "s/^pm\.max_children = [0-9]*/pm.max_children = ${max_workers}/" "$file_name"
    sleep 1
    sudo docker restart "$name"
else
    echo "[!] Container $name is not running"
    exit 1
fi
