#!/bin/bash
mount_status=$(ls /mnt/office-nas)

if [[ -n "$mount_status" ]]; then
    echo "{\"text\":\"\", \"alt\":\"󰣳\", \"class\":\"connected\" }"
else
    echo "{\"text\":\"\", \"alt\":\"󰣳\", \"class\":\"disconnected\" }"
fi
