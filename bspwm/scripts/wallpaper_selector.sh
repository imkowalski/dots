#!/usr/bin/env bash

# Directory where wallpapers are stored
WALL_DIR="$HOME/Pictures/wallpapers"
DEFAULT_WALL="$HOME/Pictures/default_wallpaper.jpg"

# Ensure directory exists
mkdir -p "$WALL_DIR"

# List files and select one via dmenu
SELECTED=$(ls "$WALL_DIR" | dmenu -i -p "Select Wallpaper:" -fn 'monospace-10' -nb '#333333' -nf '#4cc9f0' -sb '#4cc9f0' -sf '#111111')

if [[ -n "$SELECTED" ]]; then
    FILE_PATH="$WALL_DIR/$SELECTED"
    
    # 1. Preview it first
    # This opens the image in a small window. User can close it to confirm.
    feh --title "Preview: $SELECTED (Close to set)" --geometry 800x600 "$FILE_PATH" &
    PREVIEW_PID=$!
    
    # 2. Ask for confirmation in dmenu
    CONFIRM=$(echo -e "Yes\nNo" | dmenu -i -p "Set '$SELECTED' as wallpaper?" -fn 'monospace-10' -nb '#333333' -nf '#4cc9f0' -sb '#4cc9f0' -sf '#111111')
    
    # Kill the preview window
    kill $PREVIEW_PID 2>/dev/null
    
    if [[ "$CONFIRM" == "Yes" ]]; then
        # Set current background
        feh --bg-fill "$FILE_PATH"
        
        # Save as default by copying it
        cp "$FILE_PATH" "$DEFAULT_WALL"
        
        dunstify -i "$FILE_PATH" "Wallpaper" "Set to $SELECTED"
    fi
fi
