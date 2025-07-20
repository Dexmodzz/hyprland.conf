#!/usr/bin/env bash

# === CONFIG ===
main_dir="$HOME/.config/rofi"
dir="$main_dir/power_option"
theme='fullscreen'

# Uptime e hostname
uptime="$(awk '{printf "%d hour, %d minutes\n", $1/3600, ($1%3600)/60}' /proc/uptime)"
host=$(hostname)

# Opzioni principali (icone FontAwesome o simili)
shutdown=''   # Power off
reboot=''     # Reboot
lock=''       # Lock screen
suspend='⏾'    # Suspend
logout=''     # Logout

# Opzioni conferma
yes="Yes"
no="No"

# === FUNZIONI ===

# Menu principale con rofi
rofi_cmd() {
    rofi -dmenu \
        -p "Goodbye ${USER}" \
        -mesg "Uptime: $uptime" \
        -theme "${dir}/${theme}.rasi"
}

# Menu di conferma con rofi
confirm_cmd() {
    rofi -dmenu \
        -p 'Confirmation' \
        -mesg 'Are you sure?' \
        -theme "${main_dir}/rofi-confirm.rasi"
}

# Chiedi conferma all'utente
confirm_exit() {
    echo -e "${yes}\n${no}" | confirm_cmd
}

# Mostra il menu principale
run_rofi() {
    echo -e "${lock}\n${suspend}\n${logout}\n${reboot}\n${shutdown}" | rofi_cmd
}

# Esegue i comandi in base alla scelta
run_cmd() {
    selected="$(confirm_exit)"
    if [[ "$selected" == "$yes" ]]; then
        case "$1" in
            --shutdown)
                "$HOME/.config/hypr/scripts/uptime.sh"
                "$HOME/.config/hypr/scripts/notification.sh" logout
                systemctl poweroff --now
                ;;
            --reboot)
                "$HOME/.config/hypr/scripts/uptime.sh"
                "$HOME/.config/hypr/scripts/notification.sh" logout
                systemctl reboot --now
                ;;
            --lock)
                hyprlock
                ;;
            --logout)
                "$HOME/.config/hypr/scripts/uptime.sh"
                "$HOME/.config/hypr/scripts/notification.sh" logout
                hyprctl dispatch exit 0
                ;;
            --suspend)
                "$HOME/.config/hypr/scripts/uptime.sh"
                "$HOME/.config/hypr/scripts/notification.sh" logout
                systemctl suspend
                ;;
        esac
    else
        exit 0
    fi
}

# === AVVIO ===

chosen="$(run_rofi)"
case "${chosen}" in
    $shutdown)
        run_cmd --shutdown
        ;;
    $reboot)
        run_cmd --reboot
        ;;
    $lock)
        if [[ -x '/usr/bin/betterlockscreen' ]]; then
            betterlockscreen -l
        elif [[ -x '/usr/bin/hyprlock' ]]; then
            run_cmd --lock
        elif [[ -x '/usr/bin/swaylock' ]]; then
            swaylock
        fi
        ;;
    $suspend)
        run_cmd --suspend
        ;;
    $logout)
        run_cmd --logout
        ;;
esac
