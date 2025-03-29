#!/bin/bash
#
# https://github.com/nextcloud/all-in-one#how-to-stopstartupdate-containers-or-trigger-the-daily-backup-from-a-script-externally
#

set -x

name=nextcloud-aio-mastercontainer
is_running="$(docker container inspect "$name" | jq -r '.[0].State.Running')"

if [[ "$is_running" == "true" ]]; then
    sudo docker exec -it --env START_CONTAINERS=1 nextcloud-aio-mastercontainer /daily-backup.sh
else
    echo "[!] Container $name is not running"
    exit 1
fi
