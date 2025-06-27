#!/bin/bash
LAYOUT=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')
if [[ "$LAYOUT" == "English (US)" ]]; then
  echo "EN"
else
  echo "RU"
fi