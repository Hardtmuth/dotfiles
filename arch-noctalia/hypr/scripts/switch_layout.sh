#!/usr/bin/env bash

# Файл для надежного хранения текущего состояния
STATE_FILE="/tmp/hypr_layout_mode"

# Если файла нет, считаем, что мы в дефолтном dwindle
if [ ! -f "$STATE_FILE" ]; then
    echo "dwindle" > "$STATE_FILE"
fi

CURRENT_MODE=$(cat "$STATE_FILE")

# --- ЛОГИКА ПЕРЕКЛЮЧЕНИЯ ПО КРУГУ ---

if [ "$CURRENT_MODE" = "dwindle" ]; then
    # 1. ПЕРЕХОД: Dwindle -> Scrolling
    hyprctl keyword general:layout "scrolling"
    echo "scrolling" > "$STATE_FILE"
    notify-send -u low "Hyprland" "Режим: Scrolling (Лента)" -i document-swap

elif [ "$CURRENT_MODE" = "scrolling" ]; then
    # 2. ПЕРЕХОД: Scrolling -> Свободный (Каскад)
    hyprctl keyword general:layout "dwindle"
    hyprctl keyword windowrulev2 "float, class:.*"
    hyprctl keyword windowrulev2 "size 70% 70%, class:.*"
    hyprctl keyword windowrulev2 "center, class:.*"
    
    # Эффект каскада для открытых окон на текущем воркспейсе
    ACTIVE_WS=$(hyprctl activeworkspace -j | jq '.id')
    WINDOW_ADDRESSES=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $ACTIVE_WS) | .address")
    
    START_X=100
    START_Y=100
    STEP=40
    INDEX=0
    
    echo "$WINDOW_ADDRESSES" | while read -r ADDR; do
        if [ -n "$ADDR" ]; then
            X_POS=$((START_X + (INDEX * STEP)))
            Y_POS=$((START_Y + (INDEX * STEP)))
            
            # Принудительно делаем плавающим и смещаем
            hyprctl --batch "dispatch togglefloating address:$ADDR; dispatch resizewindowpixel exact 70% 70%,address:$ADDR; dispatch movewindowpixel exact $X_POS $Y_POS,address:$ADDR"
            INDEX=$((INDEX + 1))
        fi
    done
    
    echo "free" > "$STATE_FILE"
    notify-send -u low "Hyprland" "Режим: Свободный (Каскад)" -i window-pop-out

else
    # 3. ПЕРЕХОД: Свободный -> Возврат в Dwindle (Тайлинг)
    # Удаляем глобальные правила, чтобы новые окна не становились плавающими
    hyprctl keyword windowrulev2 "unset, class:.*"
    hyprctl keyword general:layout "dwindle"
    
    # Силовое возвращение всех окон текущего воркспейса в тайлинг плитки
    ACTIVE_WS=$(hyprctl activeworkspace -j | jq '.id')
    WINDOW_ADDRESSES=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $ACTIVE_WS) | .address")
    
    echo "$WINDOW_ADDRESSES" | while read -r ADDR; do
        if [ -n "$ADDR" ]; then
            # Проверяем через jq, плавает ли окно, и если да — возвращаем в тайлинг
            IS_FLOATING_NOW=$(hyprctl clients -j | jq ".[] | select(.address == \"$ADDR\") | .floating")
            if [ "$IS_FLOATING_NOW" = "true" ]; then
                hyprctl dispatch togglefloating address:$ADDR
            fi
        fi
    done
    
    echo "dwindle" > "$STATE_FILE"
    notify-send -u low "Hyprland" "Режим: Dwindle (Тайлинг)" -i window-new
    # Отправляем сигнал реального времени для обновления виджета в панели
    #pkill -SIGRTMIN+8 noctalia
    noctalia-shell ipc call bar refresh
fi
