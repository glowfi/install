#!/bin/fish

### Plasma Bindings

## File Manager
#super + f
    dolphin

## Editor
#super + k
    kate

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
    cp -r ~/install/scripts/toggle.sh ~;chmod +x toggle.sh;./toggle.sh;rm -rf ~/toggle.sh;

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
