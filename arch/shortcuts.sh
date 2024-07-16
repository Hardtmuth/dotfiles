#!/bin/bash

msg1=`cat <<_EOF_
Logout:              󰘳 + M
Lock:                󰘳 + L

Terminal:            󰘳 + RETURN
Browser:             󰘳 + B
Files:               󰘳 + E
Launcher:            󰘳 + SPACE

Screenshots:
window:              󰘳 + SHIFT + S
region:              󰘳 + PRINTSCREEN
screen:              PRINTSCREEN

Clipboard history:   󰘳 + V
_EOF_`

msg2=`cat <<_EOF_
Windows actions:
Close window:        󰘳 + Q
Fullscreen:          󰘳 + F
Float:               󰘳 + T
Toggle split:        󰘳 + J
Move window:         󰘳 + 󰳽  
Resize window:       󰘳 +  󰳽

Move focus:          󰘳 +  /  /  / 
Resize:              󰘳 + SHIFT +  /  /  / 
Swap window:         󰘳 + CTRL +  /  /  / 

Create group:        󰘳 + G
Change group active: 󰘳 + ALT +  /

_EOF_`

notify-send "$msg1" -i none;
notify-send "$msg2" -i none;