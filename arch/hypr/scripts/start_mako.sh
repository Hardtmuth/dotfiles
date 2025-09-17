#!/bin/bash

LIGHT_THEME=Raleigh
DARK_THEME=Cabinet-Dark

theme=$(gsettings get org.gnome.desktop.interface gtk-theme)

killall mako
mako -c /home/link/.config/mako/config.ini &
makoctl mode -a light
makoctl mode -a dark

get_theme() {
    if [[ $theme ==  "'$LIGHT_THEME'" ]]
        then
            makoctl mode -s light
    elif [[ $theme == "'$DARK_THEME'" ]]
        then
            makoctl mode -s dark
    else
        echo "has no theme"
    fi
}

get_theme