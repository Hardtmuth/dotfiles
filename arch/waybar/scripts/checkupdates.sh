#!/bin/bash
updates=$(checkupdates-with-aur | wc -l)

if [[ $updates -gt 0 ]]; then
    echo "{\"text\":\"available\", \"alt\":\"\", \"class\":\"available\", \"percentage\":$updates }" # $updates"
else
    echo "{\"text\":\"notavailable\", \"alt\":\"󰅠\", \"class\":\"notavailable\", \"percentage\":\"\" }" #"󰅠"
fi
