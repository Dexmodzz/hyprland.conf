#!/usr/bin/env bash

dir="$HOME/.config/rofi/menu"
theme='gruvbox'

## Run
rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi
