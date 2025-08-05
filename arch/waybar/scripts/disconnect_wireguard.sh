#!/bin/bash
active_tunnel=$(wg show | grep -oP 'interface:\s+\K\w+')
if [ -n "$active_tunnel" ]; then
    sudo wg-quick down $active_tunnel
else
    echo "Нет активных туннелей"
fi