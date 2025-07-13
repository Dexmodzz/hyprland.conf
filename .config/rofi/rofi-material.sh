#!/bin/bash

THEME_PATH="/home/$USER/.local/share/rofi/themes/material-you/material-you.rasi"

if [ ! -f "$THEME_PATH" ]; then
    echo "Error theme not found in $THEME_PATH" >&2
    exit 1
fi

rofi -show drun -theme "$THEME_PATH"
