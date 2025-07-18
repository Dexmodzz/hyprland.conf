#!/usr/bin/env bash

dir="$HOME/.config/rofi/menu"
theme='material-you'

## Run
rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi
