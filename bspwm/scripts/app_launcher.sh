#!/usr/bin/env bash

set -eu

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/bspwm"
cache_file="$cache_dir/app-launcher.list"
mkdir -p "$cache_dir"

theme=(-fn 'monospace-10' -nb '#333333' -nf '#4cc9f0' -sb '#4cc9f0' -sf '#111111')

build_cache() {
    : > "$cache_file"
    for dir in "$HOME/.local/share/applications" /usr/share/applications /var/lib/flatpak/exports/share/applications /var/lib/snapd/desktop/applications; do
        [ -d "$dir" ] || continue
        while IFS= read -r -d '' file; do
            grep -q '^NoDisplay=true' "$file" 2>/dev/null && continue
            name=$(grep -m1 '^Name=' "$file" | cut -d= -f2-)
            desktop_id=$(basename "$file" .desktop)
            [ -n "$name" ] && [ -n "$desktop_id" ] && printf '%s\t%s\n' "$name" "$desktop_id" >> "$cache_file"
        done < <(find "$dir" -name '*.desktop' -print0 2>/dev/null)
    done
    sort -u "$cache_file" -o "$cache_file"
}

[ -s "$cache_file" ] || build_cache

choice=$(cut -f1 "$cache_file" | dmenu -i "${theme[@]}" -p 'Apps:')
[ -n "${choice:-}" ] || exit 0

desktop_id=$(awk -F '\t' -v n="$choice" '$1 == n { print $2; exit }' "$cache_file")
[ -n "$desktop_id" ] || exit 1

gtk-launch "$desktop_id" >/dev/null 2>&1 || xdg-open "$HOME/.local/share/applications/$desktop_id.desktop" >/dev/null 2>&1 &
