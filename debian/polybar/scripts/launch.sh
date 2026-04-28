#!/bin/bash


# Завершаем текущие экземпляры Polybar
killall -q polybar

# Ждём полного завершения процессов
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Запускаем Polybar на каждом подключённом мониторе
if type "xrandr" >/dev/null; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR="$m" polybar --reload example &
  done
else
  # Если xrandr недоступен, запускаем на одном мониторе
  polybar --reload example &
fi


echo "Polybar запущен на всех мониторах"
