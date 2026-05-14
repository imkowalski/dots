#!/usr/bin/env bash
# Simple power menu using dmenu
options="Shutdown\nReboot\nSuspend\nLogout"
choice=$(echo -e "$options" | dmenu -p "Power:" -fn 'monospace-10' -nb '#333333' -nf '#4cc9f0' -sb '#4cc9f0' -sf '#111111')

case "$choice" in
    Shutdown) systemctl poweroff ;;
    Reboot) systemctl reboot ;;
    Suspend) systemctl suspend ;;
    Logout) bspc quit ;;
esac
