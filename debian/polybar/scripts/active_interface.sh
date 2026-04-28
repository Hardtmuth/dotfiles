#!/bin/bash

# Конфигурация
CACHE_FILE="/tmp/polybar-network-cache-$(whoami)"
CACHE_TIMEOUT=60  # секунд — время жизни кэша
STARTUP_DELAY=5   # секунд — задержка при старте для инициализации сети

# Функция очистки старого кэша
cleanup_cache() {
    if [ -f "$CACHE_FILE" ]; then
        CACHE_AGE=$(( $(date +%s) - $(stat -c %Y "$CACHE_FILE" 2>/dev/null || echo 0) ))
        if [ $CACHE_AGE -gt $CACHE_TIMEOUT ]; then
            rm -f "$CACHE_FILE"
            #echo "Cache cleared (age: ${CACHE_AGE}s > ${CACHE_TIMEOUT}s)" >&2
        fi
    fi
}

# Функция задержки при старте системы
startup_delay() {
    # Проверяем, был ли недавно вход в систему (по времени запуска процесса polybar)
    POLYBAR_START=$(ps -o lstart= -p $$ 2>/dev/null | tr -s ' ' | cut -d' ' -f4)
    CURRENT_TIME=$(date +%H:%M:%S)

    # Если Polybar запущен менее 10 секунд назад — делаем задержку
    if uptime | grep -q 'up 0 min' || uptime | grep -q 'load average'; then
        sleep $STARTUP_DELAY
        echo "Startup delay completed ($STARTUP_DELAYs)" >&2
    fi
}

# Функции (остаются почти без изменений)
get_ip() {
    local iface=$1
    ip addr show "$iface" 2>/dev/null | grep -oP 'inet\s+\K\d+(\.\d+){3}' | grep -v '^127\.' | head -n1
}

get_ssid() {
    local iface=$1
    iw dev "$iface" link 2>/dev/null | grep -oP 'SSID:\s*\K.*'
}

is_active() {
    ip link show "$1" 2>/dev/null | grep -q 'state UP'
}

# Основная логика
output=""

# Очистка кэша перед выполнением
cleanup_cache

# Задержка при старте системы
startup_delay

# Проверяем Wi‑Fi
wifi_iface=$(ip link show 2>/dev/null | grep -o 'w[a-z0-9]*:' | cut -d: -f1 | head -n1)

# Проверяем проводной
wired_iface=$(ip link show 2>/dev/null | grep -o 'e[n|t][a-z0-9]*:' | cut -d: -f1 | head -n1)

if [ -n "$wifi_iface" ] && is_active "$wifi_iface"; then
    ssid=$(get_ssid "$wifi_iface")
    ip_addr=$(get_ip "$wifi_iface")

    if [ -n "$ssid" ]; then
        if [ -n "$ip_addr" ]; then
            output=" $ssid / 󰈀 $wifi_iface: $ip_addr /"
        else
            output=" $ssid / 󰈀 $wifi_iface: No IP /"
        fi
    else
        if [ -n "$ip_addr" ]; then
            output=" Connected / 󰈀 $wifi_iface: $ip_addr /"
        else
            output=" No SSID / 󰈀 $wifi_iface: No IP /"
        fi
    fi
elif [ -n "$wired_iface" ] && is_active "$wired_iface"; then
    ip_addr=$(get_ip "$wired_iface")
    if [ -n "$ip_addr" ]; then
        output="󰈀 $wired_iface: $ip_addr /"
    else
        output="󰈀 $wired_iface: No IP /"
    fi
else
    output="󰈂 No connection"
fi

# Сравниваем с кэшем и обновляем только при изменении
if [ ! -f "$CACHE_FILE" ] || [ "$(cat "$CACHE_FILE" 2>/dev/null)" != "$output" ]; then
    echo "$output" > "$CACHE_FILE"
    echo "$output"
else
    # Всегда выводим текущее состояние, даже если кэш не изменился
    cat "$CACHE_FILE" 2>/dev/null || echo "$output"
fi
