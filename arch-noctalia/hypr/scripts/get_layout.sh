#!/usr/bin/env bash
STATE_FILE="/tmp/hypr_layout_mode"
MODE=$(cat "$STATE_FILE" 2>/dev/null || echo "dwindle")

if [ "$MODE" = "dwindle" ]; then
    echo "Auto Tile"
elif [ "$MODE" = "scrolling" ]; then
    echo "Scrolling"
else
    echo "Open Space"
fi
