#!/bin/bash
mount_status=$(ls /media/link)

if [[ -n "$mount_status" ]]; then
    echo "󰟜 $mount_status"
else
    echo "󰕓 "
fi
