#!/bin/bash

set -e

# -- Update the system and install pacman-contrib
echo -e "\n\e[1;34mUpdating the system and installing pacman-contrib...\e[0m\n"
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm pacman-contrib

# -- Install yay (AUR helper)
echo -e "\n\e[1;34mInstalling yay...\e[0m\n"
sudo pacman -S --noconfirm yay

# -- Install core packages from pacman
echo -e "\n\e[1;34mInstalling core packages with pacman...\e[0m\n"
sudo pacman -S --noconfirm \
  swaync \
  sddm \
  power-profiles-daemon

# -- Enable system services
echo -e "\n\e[1;34mEnabling system services...\e[0m\n"
sudo systemctl enable sddm
sudo systemctl enable --now power-profiles-daemon.service
powerprofilesctl set performance

# -- Install AUR packages using yay
echo -e "\n\e[1;34mInstalling AUR packages with yay...\e[0m\n"
yay -S --needed --noconfirm \
  hyprland \
  waybar \
  kitty \
  power-profiles-daemon \
  hyprsunset \
  hyprlock \
  rofi-wayland \
  papirus-icon-theme \
  ttf-jetbrains-mono-nerd \
  python-pywalfox \
  adw-gtk-theme \
  qt5ct \
  swww \
  kvantum \
  kvantum-qt5 \
  pywal-spicetify \
  spicetify-cli \
  alacritty \
  brightnessctl \
  dunst \
  gtk-engine-murrine \
  gtk-engines \
  matugen-bin \
  nwg-look \
  papirus-folders \
  python-pywal16 \
  spotx-git \
  playerctl \
  nerd-fonts-noto-sans-mono \
  blueman \
  grim \
  thunar \
  brave-bin \
  swaybg \
  nerd-fonts \
  otf-font-awesome

# -- Install fonts
echo -e "\n\e[1;34mInstalling fonts...\e[0m\n"
font_dir="$HOME/.local/share/fonts/ttf"
mkdir -p "$font_dir"
cp -r ./fonts/ttf/* "$font_dir"
fc-cache -fv

# -- Backup existing configuration
echo -e "\n\e[1;34mBacking up existing configuration...\e[0m\n"
bash ./backup_config.sh

# -- Copy configuration files
echo -e "\n\e[1;34mCopying configuration files...\e[0m\n"

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

echo -e "\n\e[1;32mConfiguration files copied successfully!\e[0m\n"

# -- Install custom scripts
echo -e "\n\e[1;34mInstalling custom scripts...\e[0m\n"

mkdir -p "$HOME"/.local/bin

cp ./.local/bin/menu.sh "$HOME"/.local/bin
cp ./.local/bin/powermenu.sh "$HOME"/.local/bin
cp ./.local/bin/set-wallpaper.sh "$HOME"/.local/bin

chmod +x "$HOME"/.local/bin/{walset,menu.sh,powermenu.sh,set-wallpaper.sh}

# -- Add ~/.local/bin to PATH if not already added
if [[ "$SHELL" == */bash ]]; then
    grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
elif [[ "$SHELL" == */zsh ]]; then
    grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' ~/.zshrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
elif [[ "$SHELL" == */fish ]]; then
    grep -qxF 'set -Ux PATH $HOME/.local/bin $PATH' ~/.config/fish/config.fish || echo 'set -Ux PATH $HOME/.local/bin $PATH' >> ~/.config/fish/config.fish
else
    echo "Unsupported shell. Please add ~/.local/bin to PATH manually."
fi

echo -e "\n\e[1;32mInstallation complete!\e[0m\n"
