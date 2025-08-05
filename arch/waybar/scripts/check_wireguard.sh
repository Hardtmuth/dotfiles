#!/bin/bash
connection_status=$(wg show | grep -oP 'interface:\s+\K\w+')

if [[ -n "$connection_status" ]]; then
    echo "{\"text\":\"$connection_status\", \"alt\":\"󰖂\", \"class\":\"connected\" }"
else
    echo "{\"text\":\"\", \"alt\":\"󰖂\", \"class\":\"disconnected\" }"
fi
