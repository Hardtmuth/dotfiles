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
theme='style-onecol-thin-short'
## Run
office_nas='office-nas' #'//10.0.1.29/obmen'
home_nas='home-nas' #'//10.37.40.19/home'
home_desktop='home-desktop' #'//10.37.40.29'

rofi_cmd() {
	rofi -dmenu \
		-theme ${dir}/${theme}.rasi
}

run_rofi() {
	echo -e "$office_nas\n$home_nas\n$home_desktop" | rofi_cmd
}

chosen="$(run_rofi)"
case ${chosen} in
    $office_nas)
		kitty sudo mount -t cifs //10.0.1.29/obmen /mnt/office-nas -o username=aa,password=TestTest123!,uid=$(id -u)
        ;;
	$home_nas)
		kitty sudo mount -t cifs //10.37.40.19/home /mnt/home-nas -o username=link,uid=$(id -u)
        ;;
	$home_desktop)
		kitty sudo mount -t cifs //10.37.40.29/share /mnt/home-desktop -o username=link,uid=$(id -u)
        ;;
esac
