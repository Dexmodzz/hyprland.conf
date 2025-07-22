# Hello, Dear User!

This repository contains configuration files, themes, fonts, and scripts for a custom Linux environment (optimized for Hyprland and Wayland on Arch or derivative distributions).

## 1. Download or Clone

- **Download ZIP**: Click the green `Code` button → `Download ZIP`, then extract it.
**Or clone using Git**
- **cd hyprland.conf**
- **sudo chmod +x install.sh**
- **bash install.sh**

## 2. Change Wallpapers (and themes)

**To apply wallpapers**, just make sure you have image files in the folder **~/Pictures/Wallpapers. If it doesn't exist, create it** and place your wallpapers inside.
Then, **press Ctrl + T** to open the rofi theme selector and apply a wallpaper.

## 3. Change GTK Theme

Usually, your GTK theme will be one that you've chosen specifically or the default. Run
this to change it to Material colors:

```
gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"
```

## 4. Keybinds

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
    <td>Open Brave-Browser Or Your Default Browser You Have Set Up</td>
    <td>Super + B</td>
  </tr>
  <tr>
  <td>Open Brave-Browser Or Your Default Browser You Have Set Up in Private</td>
    <td>Super + I</td>
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

# Final Notes

As additional bonuses, I added in:

1. Improved font rendering so that all fonts look as crisp as possible :)

Thank you!
