#!/bin/bash

# Путь к временному файлу-флагу
FLAG_FILE="/tmp/hypr_gaps_enabled"

# Проверяем, существует ли файл-флаг
if [ -f "$FLAG_FILE" ]; then
    # Если файл есть — значит правило включено. Выключаем его!
    hyprctl keyword workspace "w[t1], gapsout:8 12"
    # Удаляем файл-флаг
    rm "$FLAG_FILE"
else
    # Если файла нет — включаем правило!
    hyprctl keyword workspace "w[t1], gapsout:200 400"
    # Создаем файл-флаг
    touch "$FLAG_FILE"
fi