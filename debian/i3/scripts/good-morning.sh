#!/bin/bash
nohup chromium &
nohup flatpak run com.ticktick.TickTick &
nohup evolution &
nohup flatpak run org.telegram.desktop &
nohup Bitrix24 &
nohup remotedesktopmanager &
killall kitty