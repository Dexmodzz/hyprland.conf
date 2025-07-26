#!/bin/bash

set -e

# === Functions ===

install_if_missing() {
    for pkg in "$@"; do
        if pacman -Q "$pkg" &>/dev/null; then
            echo -e "\e[1;32m✓ $pkg is already installed\e[0m"
        else
            echo -e "\e[1;33m→ Installing $pkg...\e[0m"
            sudo pacman -S --noconfirm "$pkg"
        fi
    done
}

install_aur_if_missing() {
    for pkg in "$@"; do
        if pacman -Q "$pkg" &>/dev/null; then
            echo -e "\e[1;32m✓ $pkg is already installed (AUR)\e[0m"
        else
            echo -e "\e[1;33m→ Installing $pkg from AUR...\e[0m"
            yay -S --noconfirm "$pkg"
        fi
    done
}

# === System update ===

echo -e "\n\e[1;34m🔄 Updating system and installing pacman-contrib and yay...\e[0m\n"
sudo pacman -Syu --noconfirm
install_if_missing pacman-contrib yay

# === KDE Plasma 6 Minimal ===

echo -e "\n\e[1;34m🖥️ Installing minimal KDE Plasma 6 environment...\e[0m\n"
install_if_missing plasma-desktop konsole dolphin ark sddm \
    systemsettings plasma-pa kde-gtk-config xdg-desktop-portal-kde

# === Core Packages ===

echo -e "\n\e[1;34m📦 Installing core packages...\e[0m\n"
install_if_missing swaync power-profiles-daemon bluez rfkill libnotify kate

# === Network Packages ===

echo -e "\n\e[1;34m🌐 Installing network packages...\e[0m\n"
install_if_missing networkmanager network-manager-applet libappindicator-gtk3 papirus-icon-theme \
    nm-connection-editor wireless_tools wpa_supplicant dialog

# === Enable System Services ===

echo -e "\n\e[1;34m⚙️ Enabling system services...\e[0m\n"
sudo systemctl enable --now sddm
sudo systemctl enable --now power-profiles-daemon.service
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now NetworkManager.service
powerprofilesctl set performance

# === Hyprland Default Session for SDDM ===

echo -e "\n\e[1;34m🧠 Creating Hyprland session for SDDM...\e[0m\n"
sudo mkdir -p /usr/share/wayland-sessions
sudo tee /usr/share/wayland-sessions/hyprland.desktop >/dev/null <<EOF
[Desktop Entry]
Name=Hyprland
Comment=An intelligent dynamic tiling Wayland compositor
Exec=Hyprland
Type=Application
DesktopNames=Hyprland
EOF

echo -e "\n\e[1;34m🔧 Setting Hyprland as default session in SDDM...\e[0m\n"
sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/default.conf >/dev/null <<EOF
[Autologin]
User=$USER
Session=hyprland.desktop

[General]
Session=hyprland.desktop
EOF

# === AUR Packages ===

echo -e "\n\e[1;34m📦 Installing AUR packages...\e[0m\n"
install_aur_if_missing \
    hyprland waybar kitty power-profiles-daemon hyprsunset hyprlock \
    rofi-wayland ttf-jetbrains-mono-nerd python-pywalfox \
    adw-gtk-theme qt5ct swww kvantum kvantum-qt5 pywal-spicetify spicetify-cli \
    alacritty brightnessctl dunst gtk-engine-murrine gtk-engines matugen-bin \
    nwg-look papirus-folders python-pywal16 spotx-git playerctl \
    nerd-fonts-noto-sans-mono blueman grim thunar brave-bin swaybg \
    nerd-fonts otf-font-awesome

# === Fonts ===

echo -e "\n\e[1;34m🖋️ Installing fonts...\e[0m\n"
font_dir="$HOME/.local/share/fonts/ttf"
mkdir -p "$font_dir"
cp -r ./fonts/ttf/* "$font_dir"
fc-cache -fv

# === Backup Configuration ===

echo -e "\n\e[1;34m💾 Backing up existing configuration...\e[0m\n"
bash ./backup_config.sh

# Thunar and GTK bookmarks
mkdir -p ./thunar-backup
cp -r ~/.config/Thunar ./thunar-backup/ 2>/dev/null || true
cp ~/.config/gtk-3.0/bookmarks ./thunar-backup/ 2>/dev/null || true

# === Copy Config Files ===

echo -e "\n\e[1;34m📁 Copying configuration files...\e[0m\n"
mkdir -p ~/.icons
cp -a .icons/Simp1e-Dark ~/.icons/

# Rofi themes
rofi_theme_dir=".local/share/rofi/themes/material-you"
mkdir -p ~/$rofi_theme_dir
cp -a ./$rofi_theme_dir/* ~/$rofi_theme_dir/

# GTK / Kvantum themes
themes_dir=".themes"
mkdir -p ~/$themes_dir
cp -a ./$themes_dir/* ~/$themes_dir

# GTK 2.0 config
cp .gtkrc-2.0 ~/.gtkrc-2.0

# GTK 3.0 / 4.0 config
rm -rf ~/.config/gtk-3.0 ~/.config/gtk-4.0
cp -r ./.config/gtk-3.0 ~/.config/
cp -r ./.config/gtk-4.0 ~/.config/

# Other configs
cp -a ./.config/* ~/.config/

# Restore Thunar config
mkdir -p ~/.config/Thunar
cp -r ./thunar-backup/Thunar/* ~/.config/Thunar/ 2>/dev/null || true
mkdir -p ~/.config/gtk-3.0
cp ./thunar-backup/bookmarks ~/.config/gtk-3.0/ 2>/dev/null || true

# === Custom Scripts ===

echo -e "\n\e[1;34m⚙️ Installing custom scripts...\e[0m\n"
mkdir -p "$HOME/.local/bin"
cp ./.local/bin/menu.sh "$HOME/.local/bin"
cp ./.local/bin/powermenu.sh "$HOME/.local/bin"
cp ./.local/bin/set-wallpaper.sh "$HOME/.local/bin"
chmod +x "$HOME/.local/bin/"{menu.sh,powermenu.sh,set-wallpaper.sh}

# === Add ~/.local/bin to PATH ===

if [[ "$SHELL" == */bash ]]; then
    grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
elif [[ "$SHELL" == */zsh ]]; then
    grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' ~/.zshrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
elif [[ "$SHELL" == */fish ]]; then
    grep -qxF 'set -Ux PATH $HOME/.local/bin $PATH' ~/.config/fish/config.fish || echo 'set -Ux PATH $HOME/.local/bin $PATH' >> ~/.config/fish/config.fish
else
    echo "⚠️ Unknown shell. Please add ~/.local/bin to PATH manually."
fi

echo -e "\n\e[1;32m🎉 Installation complete! Hyprland will start by default via SDDM.\e[0m\n"
