#!/bin/bash
#
# https://github.com/nextcloud/all-in-one#how-to-stopstartupdate-containers-or-trigger-the-daily-backup-from-a-script-externally
#
# If the mastercontainer gets updated, this script's execution will stop as soon
# as the mastercontainer gets stopped. You can then wait until it is started
# again and run the script with this flag again in order to update all
# containers correctly afterwards.
#

set -x

name=nextcloud-aio-mastercontainer
is_running="$(docker container inspect "$name" | jq -r '.[0].State.Running')"

if [[ "$is_running" == "true" ]]; then
    sudo docker exec -it --env AUTOMATIC_UPDATES=1 nextcloud-aio-mastercontainer /daily-backup.sh
else
    echo "[!] Container $name is not running"
    exit 1
fi
