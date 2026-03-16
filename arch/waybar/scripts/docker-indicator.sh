#!/bin/bash
docker_status=$(docker ps --format '{{.Names}}')
container_count=$(echo "$docker_status" | grep -c -E '^[^[:space:]]')

if [[ $container_count -gt 0 ]]; then
    if [[ $container_count -eq 1 && -n "$docker_status" ]]; then
        echo "{\"text\":\"$docker_status\", \"alt\":\"\", \"class\":\"runned\" }"
    else
        echo "{\"text\":\"$container_count\", \"alt\":\"\", \"class\":\"runned\" }"
    fi
else
    echo "{\"text\":\"\", \"alt\":\" \", \"class\":\"stopped\" }"
fi
