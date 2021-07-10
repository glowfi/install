#!/bin/sh

# Toggle Tiling Support

current=`kreadconfig5 --file kwinrc --group Plugins --key krohnkiteEnabled`

if [ $current = "true" ]; then
  kwriteconfig5 --file kwinrc --group Plugins --key krohnkiteEnabled false
  kwriteconfig5 --file kwinrc --group Plugins --key diminactiveEnabled false
  kwriteconfig5 --file breezerc --group "Windeco Exception 0" --key Enabled false
  qdbus org.kde.plasmashell /PlasmaShell evaluateScript "p = panelById(panelIds[0]); p.location = 'bottom';p.height = 44;"
  sed -i '16s/.*/echo $XDG_CURRENT_DESKTOP/' .local/bin/fm/fetchmaster.sh
  notify-send 'Normal Mode'

elif [ $current = "false" ]; then
  kwriteconfig5 --file kwinrc --group Plugins --key krohnkiteEnabled true
  kwriteconfig5 --file kwinrc --group Plugins --key diminactiveEnabled true
  kwriteconfig5 --file breezerc --group "Windeco Exception 0" --key Enabled true
  qdbus org.kde.plasmashell /PlasmaShell evaluateScript "p = panelById(panelIds[0]); p.location = 'top';p.height = 25;"
  sed -i '16s/.*/echo $XDG_CURRENT_DESKTOP\/Krohnkite /' .local/bin/fm/fetchmaster.sh
  notify-send 'Tiling Mode'
fi

# Reconfigure Kwin

qdbus org.kde.KWin /KWin reconfigure
