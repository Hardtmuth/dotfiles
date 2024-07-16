#!/usr/bin/env bash

op=$( echo -e "  Poweroff\n Reboot\n Suspend\n  Lock\n Logout" | wofi -c ~/Documents/wofi_actions/powermenu_wofi_config | awk '{print tolower($2)}' )

case $op in 
        poweroff)
                systemctl poweroff
                ;;
        reboot)
                systemctl reboot
                ;;
        suspend)
                systemctl suspend
                ;;
        lock)
		hyprlock
                ;;
        logout)
                hyprctl dispatch exit 0
                ;;
esac