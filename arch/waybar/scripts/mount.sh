#!/bin/bash
mount_status=$(ls /run/media/link)

if [[ -n "$mount_status" ]]; then
    echo "{\"text\":\"$mount_status\", \"alt\":\"󰟜\", \"class\":\"connected\" }"
else
    echo "{\"text\":\"\", \"alt\":\"\", \"class\":\"disconnected\" }"
fi
