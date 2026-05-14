#!/usr/bin/env bash
# Battery monitor script
NOTIFY_ID=9911

while true; do
    capacity=$(cat /sys/class/power_supply/BATT/capacity 2>/dev/null || echo 100)
    status=$(cat /sys/class/power_supply/BATT/status 2>/dev/null || echo "Unknown")

    if [[ "$status" != "Charging" && "$capacity" -le 15 ]]; then
        dunstify -u critical -t 0 -r "$NOTIFY_ID" "Battery Low" "Battery is at ${capacity}%! Please plug in."
    fi

    if [[ "$status" == "Charging" || "$capacity" -gt 15 ]]; then
        dunstify -C "$NOTIFY_ID" 2>/dev/null || true
    fi

    sleep 60
done
