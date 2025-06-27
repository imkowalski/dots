REGION=$(slurp) || exit; grim -g "$REGION" - | wl-copy &&  wl-paste > ~/Pictures/Screenshots/$(date +%F_%T).png
hyprctl notify 5 2000 "rgb(ffffff)" "Area screenshot taken $(date +%F_%T).png"