#!/usr/bin/env bash
# Screen mirroring script using dmenu
options="Mirror\nExtend\nInternal Only\nExternal Only"
choice=$(echo -e "$options" | dmenu -p "Display:" -fn 'monospace-10' -nb '#333333' -nf '#4cc9f0' -sb '#4cc9f0' -sf '#111111')

case "$choice" in
    Mirror) xrandr --output HDMI-1 --same-as eDP-1 --auto 2>/dev/null || xrandr --output HDMI-A-0 --same-as eDP-1 --auto ;;
    Extend) xrandr --output HDMI-1 --right-of eDP-1 --auto 2>/dev/null || xrandr --output HDMI-A-0 --right-of eDP-1 --auto ;;
    "Internal Only") xrandr --output eDP-1 --auto --output HDMI-1 --off 2>/dev/null || xrandr --output HDMI-A-0 --off ;;
esac
