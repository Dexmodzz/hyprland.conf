#!/bin/bash

# -- Install fonts
echo -e "\n\e[1;34mInstalling fonts...\e[0m\n"
font_dir="$HOME/.local/share/fonts/ttf"

mkdir -p "$font_dir"
cp -r ./fonts/ttf/* "$font_dir"
fc-cache -fv # Refresh font cache

# -- Backup existing configs
echo -e "\n\e[1;34mBacking up existing folders...\e[0m\n"
bash ./backup_config.sh

# -- Move config files to their places
echo -e "\n\e[1;34mCopying configuration files over...\e[0m\n"

mkdir -p ~/.icons
cp -a .icons/Simp1e-Dark ~/.icons/

rofi_theme_dir=".local/share/rofi/themes/material-you"
mkdir -p ~/$rofi_theme_dir
cp -a ./$rofi_theme_dir/* ~/$rofi_theme_dir/

themes_dir=".themes"
mkdir -p ~/$themes_dir
cp -a ./$themes_dir/* ~/$themes_dir

cp .gtkrc-2.0 ~/.gtkrc-2.0

cp -a ./.config/* ~/.config/

echo -e "\n\e[1;32mConfiguration files moved successfully!\e[0m\n"

# Install the wallpaper changer
echo -e "\n\e[1;34mInstalling wallpaper changer...\e[0m\n"

mkdir -p "$HOME"/.local/bin
cp ./.local/bin/walset "$HOME"/.local/bin

if [[ "$SHELL" == */bash ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
elif [[ "$SHELL" == */zsh ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
elif [[ "$SHELL" == */fish ]]; then
    echo 'set -Ux PATH $HOME/.local/bin $PATH' >> ~/.config/fish/config.fish
else
    echo "Unsupported shell. Please add PATH manually."
fi

echo -e "\n\e[1;32mInstallation complete!\e[0m\n"

