#!/bin/bash
mount_status=$(ls /mnt/office-nas && ls /mnt/home-nas && ls /mnt/home-desktop)
#echo $mount_status
if [[ -n "$mount_status" ]]; then
    echo "{\"text\":\"\", \"alt\":\"󰣳\", \"class\":\"connected\" }"
else
    echo "{\"text\":\"\", \"alt\":\"󰣳\", \"class\":\"disconnected\" }"
fi
