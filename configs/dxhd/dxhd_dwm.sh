#!/bin/sh

## File Manager
#super + f
    pcmanfm

## Logout/Restart/Shutdown
#super+x 
    qdbus org.kde.ksmserver /KSMServer org.kde.KSMServerInterface.logout -1 -1 -1

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
