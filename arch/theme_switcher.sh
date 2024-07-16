#!/bin/bash

CNFP=/home/link/.config

VSCODE_PATH=$CNFP/Code\ -\ OSS/User/settings.json
KITTY_PATH=$CNFP/kitty/kitty.conf
WOFI_PATH=$CNFP/wofi/style.css
WAYBAR_PATH=$CNFP/waybar/style.css

LIGHT_THEME=Adementary-light
LIGHT_ICONS=WhiteSur-light
LIGHT_VSCODE_THEME="Bearded Theme feat. Melle Julie Light"

DARK_THEME=Cabinet-Dark
DARK_ICONS=WhiteSur-dark
DARK_VSCODE_THEME="Noctis Azureus"

SCHEMA="gsettings set org.gnome.desktop.interface"

apply_themes() {
    if [[ $1 == "light" ]]
    then
        ${SCHEMA} gtk-theme "$LIGHT_THEME"
        ${SCHEMA} icon-theme "$LIGHT_ICONS"
        ${SCHEMA} color-scheme "prefer-light"
        sed -i "s/$DARK_VSCODE_THEME/$LIGHT_VSCODE_THEME/g" "$VSCODE_PATH"
        sed -i "s/dark/light/" "$KITTY_PATH"
        sed -i "s/dark/light/" "$WOFI_PATH"
        sed -i "s/dark/light/" "$WAYBAR_PATH"

    elif [[ $1 == "dark" ]]
        then
        ${SCHEMA} gtk-theme "$DARK_THEME"
        ${SCHEMA} icon-theme "$DARK_ICONS"
        ${SCHEMA} color-scheme "prefer-dark"
        sed -i "s/$LIGHT_VSCODE_THEME/$DARK_VSCODE_THEME/g" "$VSCODE_PATH"
        sed -i "s/light/dark/" "$KITTY_PATH"
        sed -i "s/light/dark/" "$WOFI_PATH"
        sed -i "s/light/dark/" "$WAYBAR_PATH"
    else
        echo "use only 'light' or 'dark' params"
    fi

    # restart terminal
    TERMINAL=kitty

    if [[ `pgrep $TERMINAL | wc -m` > 0 ]]
        then
            pgrep $TERMINAL | xargs -I {} kill -9 {}
            $TERMINAL || ./$TERMINAL &
    fi
}

apply_themes $1