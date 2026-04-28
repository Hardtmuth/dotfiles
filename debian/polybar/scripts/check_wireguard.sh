#!/bin/bash
connection_status=$(sudo wg show | grep -oP 'interface:\s+\K\w+')

if [[ -n "$connection_status" ]]; then
    echo "%{F#3d818f}󰖂  $connection_status%{F-}"
else
    echo "󰖂 "
fi
