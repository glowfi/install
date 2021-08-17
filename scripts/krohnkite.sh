#!/bin/fish

# Download Krohnkite

cd
git clone https://github.com/esjeon/krohnkite
cd krohnkite
make install
mkdir -p ~/.local/share/kservices5/
ln -s ~/.local/share/kwin/scripts/krohnkite/metadata.desktop ~/.local/share/kservices5/krohnkite.desktop
cd ..
rm -rf krohnkite


# Creating Breezerc to hide title bars

touch ~/.config/breezerc
kwriteconfig5 --file breezerc --group "Windeco Exception 0" --key BorderSize 0
kwriteconfig5 --file breezerc --group "Windeco Exception 0" --key Enabled false
kwriteconfig5 --file breezerc --group "Windeco Exception 0" --key ExceptionPattern .\*
kwriteconfig5 --file breezerc --group "Windeco Exception 0" --key ExceptionType 0
kwriteconfig5 --file breezerc --group "Windeco Exception 0" --key HideTitleBar true
kwriteconfig5 --file breezerc --group "Windeco Exception 0" --key Mask 16

# Install Forceblur
cp -r ~/install/configs/forceblur-0.5.kwinscript ~
plasmapkg2 -i ~/forceblur-0.5.kwinscript || plasmapkg2 -u ~/forceblur-0.5.kwinscript
rm -rf ~/forceblur-0.5.kwinscript

# Copy forceblur.desktop
mkdir -p ~/.local/share/kservices5/
cp ~/.local/share/kwin/scripts/forceblur/metadata.desktop ~/.local/share/kservices5/forceblur.desktop

# Update kwinrc
kwriteconfig5 --file kwinrc --group Plugins --key blurEnabled true
kwriteconfig5 --file kwinrc --group Plugins --key forceblurEnabled true
kwriteconfig5 --file kwinrc --group Script-forceblur --key patterns kitty
kwriteconfig5 --file kwinrc --group Effect-Blur --key BlurStrength 10
qdbus org.kde.KWin /KWin reconfigure
