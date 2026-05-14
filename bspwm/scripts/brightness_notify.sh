#!/usr/bin/env bash
brightness=$(brightnessctl info | grep -oP '\d+%' | head -1)
dunstify -a "Brightness" -u low -h string:x-dunst-stack-tag:brightness "Brightness: $brightness"
