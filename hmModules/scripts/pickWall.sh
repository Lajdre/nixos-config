#!/usr/bin/env bash

IMAGE_DIR="$HOME/cave/walls"

SELECTED_IMAGE=$(find "$IMAGE_DIR" -type f -printf "%f\n" | rofi -theme purple -font 'Agave Nerd Font 17' -dmenu -p "Wall")

if [ -n "$SELECTED_IMAGE" ]; then
  awww img "$IMAGE_DIR/$SELECTED_IMAGE" --transition-step 1
fi
