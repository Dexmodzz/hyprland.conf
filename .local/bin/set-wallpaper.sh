#!/bin/bash

# Path to your wallpapers folder
WALL_DIR="$HOME/Pictures/Wallpapers"

# Path to your custom Rofi theme (update if needed)
THEME="$HOME/.config/rofi/menu/material-you.rasi"

# Check if the wallpaper directory exists
if [ ! -d "$WALL_DIR" ]; then
  echo "Wallpaper folder not found: $WALL_DIR"
  exit 1
fi

# Find .jpg and .png images and store full paths + basenames
FILES=()
BASENAMES=()
while IFS= read -r -d $'\0' file; do
  FILES+=("$file")
  BASENAMES+=("$(basename "$file")")
done < <(find "$WALL_DIR" -maxdepth 1 \( -iname '*.jpg' -o -iname '*.png' \) -print0)

# Exit if no images found
if [ ${#FILES[@]} -eq 0 ]; then
  echo "No images found in $WALL_DIR"
  exit 1
fi

# Build Rofi list with icons (thumbnails)
ROFI_LIST=""
for i in "${!BASENAMES[@]}"; do
  ROFI_LIST+="${BASENAMES[i]}\0icon\x1f${FILES[i]}\n"
done

# Show Rofi with icons and theme
SELECTED=$(echo -en "$ROFI_LIST" | rofi -dmenu -i -p "Choose wallpaper:" -show-icons -theme "$THEME")

# If nothing selected, exit
if [ -z "$SELECTED" ]; then
  echo "No image selected"
  exit 0
fi

# Find index of selected file
INDEX=-1
for i in "${!BASENAMES[@]}"; do
  if [[ "${BASENAMES[i]}" == "$SELECTED" ]]; then
    INDEX=$i
    break
  fi
done

# Validate index
if [ "$INDEX" -eq -1 ]; then
  echo "Invalid selection"
  exit 1
fi

# Set wallpaper using swaybg (kill old instance if needed)
FILEPATH="${FILES[INDEX]}"
pkill swaybg 2>/dev/null
swaybg -o '*' -i "$FILEPATH" -m fill &

echo "Wallpaper set: $FILEPATH"
