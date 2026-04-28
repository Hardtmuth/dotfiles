#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10
## style-11    style-12    style-13    style-14    style-15

dir="$HOME/.config/rofi/launchers/type-1"
theme='style-onecol'

## Run
# cliphist list | rofi -dmenu -theme ${dir}/${theme}.rasi | cliphist decode | wl-copy

#!/bin/bash

# Сохраняем текущее содержимое буфера
CURRENT=$(xclip -o -selection clipboard 2>/dev/null)

# Добавляем в историю (файл ~/.cache/clipboard_history)
if [ -n "$CURRENT" ]; then
    echo "$CURRENT" >> ~/.cache/clipboard_history
fi

# Убираем дубликаты, оставляем последние 50 записей
sort -u -r ~/.cache/clipboard_history | head -50 > ~/.cache/clipboard_temp
mv ~/.cache/clipboard_temp ~/.cache/clipboard_history

# Показываем историю в Rofi
SELECTED=$(tac ~/.cache/clipboard_history | rofi -dmenu -theme ${dir}/${theme}.rasi)

if [ -n "$SELECTED" ]; then
    echo "$SELECTED" | xclip -selection clipboard
fi