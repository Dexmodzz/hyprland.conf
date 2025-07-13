# Hello, dear user!

Given below is a list of a few steps to follow to ensure that the configuration works on your
system:

## 1. Install dependencies

first update the system


```
sudo pacman -Syu
sudo pacman -S pacman-contrib
sudo pacman -S swaync
```

Install the required programs with any AUR helper of your choice; here, yay is used.

```
yay -S --needed hyprland waybar kitty power-profiles-daemon hyprsunset hyprlock rofi-wayland papirus-icon-theme ttf-jetbrains-mono-nerd python-pywalfox adw-gtk-theme qt5ct swww kvantum kvantum-qt5 pywal-spicetify spicetify-cli alacritty brightnessctl dunst gtk-engine-murrine gtk-engines hyprlock matugen-bin nwg-look papirus-folders python-pywal16 spotx-git playerctl nerd-fonts-noto-sans-mono blueman grim thunar
```

## 2. Run script

A script titled `install.sh` is provided which will <b>install required fonts</b> and <b>backup
your existing configuration</b> by copying conflicting folders to a different location
before overwriting them.

Run it using:

```
bash ./install.sh
```

If you prefer manual installation, kindly copy only the folders of the apps you want to theme
using `cp -r ./.config/<chosen_folder> ~/.config` or drag and drop using your preferred GUI file
manager.

## 3. Configure high-performance mode

Enable the `power-profiles-daemon` using:

```
sudo systemctl enable --now power-profiles-daemon.service
```

This will allow you to choose between balanced, power-saver and performance modes using a button
at the top-right of the bar to control power consumption. If unneccessary on a desktop, remove the
module from the bar and control it through the command line with:

```
powerprofilesctl set performance
```

## 4. Change wallpapers (and themes)

Add all your wallpapers to `~/Pictures/Wallpapers` (case-sensitive) and change the theme by pressing Super + T. If you want to change the wallpaper directory, open `~/.local/bin/walset` and change `WALL_DIR` to the path where you store wallpapers.

## 5. Change GTK theme

Usually, your GTK theme will be one that you've chosen specifically or the default. Run
this to change it to Material colors:

```
gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"
```

## 6. Keybinds

<table>
  <tr>
    <th>Action</th>
    <th>Bind</th>
  </tr>
  <tr>
    <td>Open terminal</td>
    <td>Super + Return</td>
  </tr>
  <tr>
    <td>Take screenshot</td>
    <td>Super + Print</td>
  </tr>
  <tr>
    <td>Close active window</td>
    <td>Super + W</td>
  </tr>
  <tr>
    <td>Exit Hyprland</td>
    <td>Super + M</td>
  </tr>
  <tr>
    <td>Open file manager (Thunar)</td>
    <td>Super + E</td>
  </tr>
  <tr>
    <td>Toggle floating mode</td>
    <td>Super + V</td>
  </tr>
  <tr>
    <td>Toggle fullscreen</td>
    <td>Super + F</td>
  </tr>
  <tr>
    <td>Open application launcher</td>
    <td>Super + D</td>
  </tr>
  <tr>
    <td>Restart Waybar and SwayNotificationCenter</td>
    <td>Super + R</td>
  </tr>
  <tr>
    <td>Open LibreWolf browser (if installed)</td>
    <td>Super + B</td>
  </tr>
  <tr>
    <td>Apply wallpaper</td>
    <td>Super + T</td>
  </tr>
  <tr>
    <td>Open notification center</td>
    <td>Super + A</td>
  </tr>
  <tr>
    <td>Enable night mode</td>
    <td>Super + N</td>
  </tr>
  <tr>
    <td>Enable speed mode</td>
    <td>Win + F1</td>
  </tr>
  <tr>
    <td>Play/Pause media</td>
    <td>XF86AudioPlay</td>
  </tr>
  <tr>
    <td>Previous track</td>
    <td>XF86AudioPrev</td>
  </tr>
  <tr>
    <td>Next track</td>
    <td>XF86AudioNext</td>
  </tr>
  <tr>
    <td>Lock screen</td>
    <td>Super + L</td>
  </tr>
</table>

Scroll up or down using the mouse on the media module in Waybar to skip to the next track or move to the previous.

<br>

# Final notes

As additional bonuses, I added in:

1. Ad-free Spotify and its theming based on the wallpaper you choose (Note: you might have to pass in `-enable-features=UseOzonePlatform -ozone-platform=wayland` if Spotify doesn't open).

2. Improved font rendering so that all fonts look as crisp as possible :)

If you loved this and want me to make something like this specifically for you, head on over to https://sane1090x.github.io/hyprstylish and make an order!

Thank you!
