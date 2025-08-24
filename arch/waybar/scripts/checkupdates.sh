#!/bin/bash
updates=$(checkupdates-with-aur | wc -l)

if [[ $updates -gt 0 ]]; then
    echo "{\"text\":\"$updates\", \"alt\":\"\", \"class\":\"available\", \"percentage\":$updates }" # $updates"
else
    echo "{\"text\":\"\", \"alt\":\"󰅠\", \"class\":\"notavailable\", \"percentage\":\"\" }" #"󰅠"
fi
