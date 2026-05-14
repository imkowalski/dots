#!/usr/bin/env bash
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1)
dunstify -a "Volume" -u low -h string:x-dunst-stack-tag:volume "Volume: $volume"
