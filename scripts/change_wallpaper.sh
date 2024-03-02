#!/bin/bash

#path="~/Documents/generate_image/"
img="$(ls ~/Documents/generate_image/wallpapers | shuf -n 1)"
dir="~/Documents/generate_image/wallpapers/$img"
text=$(printf "preload = %s\nwallpaper = eDP-1,%s\nsplash = false\n" "$dir" "$dir")

#kitty icat $text
echo $dir
echo "$text" > ~/.config/hypr/hyprpaper.conf

