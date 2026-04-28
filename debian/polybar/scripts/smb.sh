#!/bin/bash

directories=("office-nas" "home-nas" "home-desktop")
mounted_dirs=()

for dir in "${directories[@]}"; do
    if mount | grep -q " on /mnt/$dir "; then
        mounted_dirs+=("$dir")
    fi
done

if [[ ${#mounted_dirs[@]} -gt 0 ]]; then
    echo "󰒍  ${mounted_dirs[*]}"
else
    echo "󰒍  "
fi
