#!/bin/sh

## File Manager
#super + f
    pcmanfm

## Logout/Restart/Shutdown
#super+x 
    chosen=$(echo -e "[Cancel]\nLogout\nShutdown\nReboot\nLock" | dmenu -i)

    if [[ $chosen = "Logout" ]]; then
        killall dwm
    elif [[ $chosen = "Shutdown" ]]; then
        systemctl poweroff
    elif [[ $chosen = "Reboot" ]]; then
        systemctl reboot
    elif [[ $chosen = "Lock" ]]; then
        slock
    elif [[ $chosen = "[Cancel]" ]]; then
        notify-send -t 1000 "Program terminated!" 
    fi

### Global bindings

## Terminal
#super + t
    kitty

## Browser
#super + b
    brave

## Network
#super + n
    kitty -e "nmtui"

## Network
#super + v
    kitty -e "pulsemixer"

## Screenshot
#alt + s
    flameshot gui

## Dmenu
#super + w
    dmenu_run -l 3 -fn "Fantasque Sans Mono Bold"

## Random Wallpaper
#super + z
    find $HOME/wall -type f -name *.jpg -o -name *.png | shuf -n 1 | xargs -I {} feh --bg-fill {}