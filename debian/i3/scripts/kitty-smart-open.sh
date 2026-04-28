#!/bin/bash

# Получаем имя текущего рабочего стола
CURRENT_WS=$(i3-msg -t get_workspaces | jq -r '.[].focused | select(. == true) | .name')

# Если не удалось получить имя рабочего стола, выходим
if [ -z "$CURRENT_WS" ]; then
    echo "Error: Could not determine current workspace"
    kitty &
    exit 1
fi

# Получаем количество окон на текущем рабочем столе
WINDOW_COUNT=$(i3-msg -t get_tree | jq --arg ws_name "$CURRENT_WS" '
  .. | select(.type? == "workspace" and .name == $ws_name) |
  .nodes? | map(select(.window? != null)) | length
')

# Запускаем kitty
kitty &
KITTY_PID=$!

# Ждём немного, чтобы окно появилось
sleep 0.2

# Проверяем, что окно kitty действительно запущено
if ps -p $KITTY_PID > /dev/null; then
    # Если других окон нет (или только dock), делаем kitty плавающим с фиксированным размером
    if [ "$WINDOW_COUNT" -eq 0 ]; then
        i3-msg '[class="Kitty"] floating enable, resize set 800 600, move position center'
    fi
else
    echo "Kitty failed to start"
fi
