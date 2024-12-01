#!/bin/python

import subprocess


output = subprocess.check_output("hyprctl monitors", shell=True, text=True)
print(output)
if "ID 0" and "ID 1" in output:
    subprocess.run(['sed', '-i', 's/"eDP-1"/"DP-1"/g', '/home/link/.config/waybar/config.jsonc'])

elif "ID 0" and "ID 2" in output:
    subprocess.run(['sed', '-i', 's/"eDP-1"/"DP-2"/g', '/home/link/.config/waybar/config.jsonc'])
    subprocess.run(['sed', '-i', 's/"DP-1"/"DP-2"/g', '/home/link/.config/waybar/config.jsonc'])
else:
    subprocess.run(['sed', '-i', 's/"DP-2"/"eDP-1"/g', '/home/link/.config/waybar/config.jsonc'])
    subprocess.run(['sed', '-i', 's/"DP-1"/"eDP-1"/g', '/home/link/.config/waybar/config.jsonc'])