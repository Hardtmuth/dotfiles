#!/bin/bash
CNFP=/home/link/.config

#KITTY_PATH=$CNFP/kitty/kitty.conf
ROFI_PATH=$CNFP/rofi/launchers/type-1/shared/colors.rasi
ROFI_PM_PATH=$CNFP/rofi/powermenu/type-1/shared/colors.rasi
WAYBAR_PATH=$CNFP/waybar/style.css
MAKO_PATH=$CNFP/mako/config
GTK3INI_PATH="$CNFP/gtk-3.0/settings.ini"
QT6_PATH="$CNFP/qt6ct/qt6ct.conf"


#gtk-application-prefer-dark-theme=true
#gtk-theme-name=Cabinet-Dark

LIGHT_THEME=Bubble-Lighter
LIGHT_ICONS=WhiteSur-light

DARK_THEME=Bubble-Dark
DARK_ICONS=WhiteSur-dark

SCHEMA="gsettings set org.gnome.desktop.interface"

apply_themes() {
    if [[ $1 == "light" ]]
    then
        ${SCHEMA} gtk-theme "$LIGHT_THEME"
        ${SCHEMA} icon-theme "$LIGHT_ICONS"
        ${SCHEMA} color-scheme "prefer-light"
        #sed -i "s/dark/light/" "$KITTY_PATH"
        sed -i "s/dark/light/" "$ROFI_PM_PATH"
        sed -i "s/dark/light/" "$ROFI_PATH"
        #sed -i "s/dark/light/" "$WAYBAR_PATH"
        sed -i "s/darker/Default/" "$QT6_PATH"
        sed -i "s/gtk-application-prefer-dark-theme=true/gtk-application-prefer-dark-theme=false/" "$GTK3INI_PATH"
        sed -i "s/gtk-theme-name=$DARK_THEME/gtk-theme-name=$LIGHT_THEME/" "$GTK3INI_PATH"
        makoctl mode -s light

    elif [[ $1 == "dark" ]]
        then
        ${SCHEMA} gtk-theme "$DARK_THEME"
        ${SCHEMA} icon-theme "$DARK_ICONS"
        ${SCHEMA} color-scheme "prefer-dark"
        #sed -i "s/light/dark/" "$KITTY_PATH"
        sed -i "s/light/dark/" "$ROFI_PATH"
        sed -i "s/light/dark/" "$ROFI_PM_PATH"
        #sed -i "s/light/dark/" "$WAYBAR_PATH"
        sed -i "s/Default/darker/" "$QT6_PATH"
        sed -i "s/gtk-application-prefer-dark-theme=false/gtk-application-prefer-dark-theme=true/" "$GTK3INI_PATH"
        sed -i "s/gtk-theme-name=$LIGHT_THEME/gtk-theme-name=$DARK_THEME/" "$GTK3INI_PATH"
        makoctl mode -s dark
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

    #restart waybar
    killall -SIGUSR2 waybar
}

apply_themes $1