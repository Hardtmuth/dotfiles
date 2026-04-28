#!/bin/bash
active_smb_mount=$(findmnt -t cifs -o SOURCE | grep -oP '//\d+\.\d+\.\d+\.\d+/\w+')
if [ -n "$active_smb_mount" ]; then
    kitty sudo umount $active_smb_mount
else
    echo "Ошибка размонтирования"
fi