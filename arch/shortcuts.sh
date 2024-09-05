#!/bin/bash

msg1=`cat <<_EOF_
Logout:               + M
Lock:                 + ALT + L

Terminal:             + RETURN
Browser:              + B
Files:                + E
Launcher:             + SPACE

Screenshots:
window:               + SHIFT + S
region:               + PRINT
screen:              PRINT

Clipboard history:    + V
_EOF_`

msg2=`cat <<_EOF_
Close window:         + Q
Fullscreen:           + F
Float:                + T
Rotate:               + R

Move window:          + 󰳽  
Resize window:        +  󰳽

Move focus:           + 
Resize:               + SHIFT + 
Swap window:          + CTRL + 

Create group:         + G
Change group active:  + ALT + 
_EOF_`

notify-send -h string:bgcolor:#07273b "$msg1" -i none;
notify-send -h string:bgcolor:#07273b "$msg2" -i none;