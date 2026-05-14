#!/usr/bin/env bash

set -eu

menu() {
    printf '%s
}

choice=$(menu \
    "Refresh WiFi" \
    "Toggle WiFi" \
    "Connection Status")

case "$choice" in
    "Refresh WiFi")
        nmcli device wifi rescan >/dev/null 2>&1 || true
        dunstify "Network" "Scanning for WiFi networks..."
        ;;
    "Toggle WiFi")
        if [[ "$(nmcli radio wifi)" == "enabled" ]]; then
            nmcli radio wifi off
            dunstify "Network" "WiFi disabled"
        else
            nmcli radio wifi on
            dunstify "Network" "WiFi enabled"
        fi
        ;;
    "Connection Status")
        active=$(nmcli -t -f NAME,DEVICE connection show --active | sed 's/:/ on /')
        dunstify "Network" "${active:-Not connected}"
        ;;
esac
