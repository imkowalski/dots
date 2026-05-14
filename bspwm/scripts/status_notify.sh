#!/usr/bin/env bash

# Status notification script

# 1. Get Battery
if [[ -f /sys/class/power_supply/BATT/capacity ]]; then
    capacity=$(cat /sys/class/power_supply/BATT/capacity)
    status=$(cat /sys/class/power_supply/BATT/status)
    bat_icon="🔋"
    [[ "$status" == "Charging" ]] && bat_icon="⚡"
    bat_str="$bat_icon $capacity%"
else
    bat_str="No Battery"
fi

# 2. Get Volume
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1)
mute=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes" && echo "Muted" || echo "On")
vol_icon="🔊"
[[ "$mute" == "Muted" ]] && vol_icon="🔇"
vol_str="$vol_icon $volume"

# 3. Get Brightness
brightness=$(brightnessctl info | grep -oP '\d+%' | head -1)
bri_str="☀️ $brightness"

# 4. Get Date/Time
time_str="🕒 $(date '+%H:%M')"

# Send notification
dunstify -u low -h string:x-dunst-stack-tag:status \
    "System Status" \
    "$bat_str   $vol_str   $bri_str   $time_str"
