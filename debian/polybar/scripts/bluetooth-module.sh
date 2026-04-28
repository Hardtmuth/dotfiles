#!/bin/bash

BT_ICON_OFF="󰂲"  # Bluetooth выключен
BT_ICON_ON=""   # Bluetooth включён
BT_ICON_CONN="󰂱" # Bluetooth подключён

get_bluetooth_status() {
    # Проверяем, включён ли Bluetooth
    if bluetoothctl show | grep -q "Powered: yes"; then
        # Проверяем, есть ли подключённые устройства
        if bluetoothctl devices Connected | grep -q "^Device"; then
            echo "$BT_ICON_CONN"
        else
            echo "$BT_ICON_ON"
        fi
    else
        echo "$BT_ICON_OFF"
    fi
}

# Выводим текущий статус
echo "$(get_bluetooth_status)"
