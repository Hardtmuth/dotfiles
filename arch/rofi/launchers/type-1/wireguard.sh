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
theme='style-onecol-thin'
## Run
#connection_list | rofi -dmenu -theme ${dir}/${theme}.rasi

#sudo ls /etc/wireguard | grep -oP '^[^.]+' | 


wireguard_files=$(sudo ls /etc/wireguard/ | sed 's/.*\///' | sed 's/\.conf$//')

#tstroy='raduga'
#raduga='tstroy'
#crb='crb'

rofi_cmd() {
	rofi -dmenu \
		-theme ${dir}/${theme}.rasi
}

run_rofi() {
	echo -e "$wireguard_files" | rofi_cmd
}

chosen="$(run_rofi)"
wg-quick up "$chosen"

#rofi -dmenu \
#    -theme "${dir}/${theme}.rasi" \
#    -run-shell-command "kitty" #--bind-key=return:execute-selected
# Получаем список файлов из директории /etc/wireguard



