#!/bin/sh

### Plasma Bindings

## File Manager
#super + f
    dolphin

## System Settings
#super + u
    systemsettings5

## Show Panel
#alt + s
    qdbus org.kde.plasmashell /PlasmaShell evaluateScript "p = panelById(panelIds[0]); p.height = 25;"

## Hide Panel
#alt + h
    qdbus org.kde.plasmashell /PlasmaShell evaluateScript "p = panelById(panelIds[0]); p.height = -1;"

## Toggle Tiling/Floating mode
#alt + t
    current=`kreadconfig5 --file kwinrc --group Plugins --key krohnkiteEnabled`

    if [ $current = "true" ]; then
    kwriteconfig5 --file kwinrc --group Plugins --key krohnkiteEnabled false
    kwriteconfig5 --file kwinrc --group Plugins --key diminactiveEnabled false
    kwriteconfig5 --file breezerc --group "Windeco Exception 0" --key Enabled false
    qdbus org.kde.plasmashell /PlasmaShell evaluateScript "p = panelById(panelIds[0]); p.location = 'bottom';p.height = 44;"
    notify-send 'Normal Mode'

    elif [ $current = "false" ]; then
    kwriteconfig5 --file kwinrc --group Plugins --key krohnkiteEnabled true
    kwriteconfig5 --file kwinrc --group Plugins --key diminactiveEnabled true
    kwriteconfig5 --file breezerc --group "Windeco Exception 0" --key Enabled true
    qdbus org.kde.plasmashell /PlasmaShell evaluateScript "p = panelById(panelIds[0]); p.location = 'top';p.height = 25;"
    notify-send 'Tiling Mode'
    fi
    qdbus org.kde.KWin /KWin reconfigure

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

## File Manager
#alt + f
    kitty -e "nnn" -e "-d" -e "-D" -e "-e"

## Code Editor
#super + n
    kitty -e "nvim"

## Dmenu
#super + w
    dmenu_run -l 3 -fn "Fantasque Sans Mono Bold"
