#!/bin/bash

# Define the backup destination
backup_dir="$HOME/config_backup_$(date +%Y%m%d_%H%M%S)"

# List of folders to back up
folders=(
    "alacritty" "swaync" "gtk-2.0" "gtk-3.0" "gtk-4.0" "hypr" "kitty"
    "Kvantum" "matugen" "nwg-look" "qt5ct" "qt6ct" "rofi"
    "spicetify" "wal" "waybar"
)

# Create backup directory
mkdir -p "$backup_dir"

# Loop through folders and copy if they exist
for folder in "${folders[@]}"; do
    src="$HOME/.config/$folder"
    dest="$backup_dir/$folder"

    if [[ -d "$src" ]]; then
        cp -r "$src" "$dest"
        echo "Backed up $folder -> $dest"
    else
        echo "Skipping $folder (not found)"
    fi
done

echo -e "\nBackup completed! Files are in: $backup_dir"
