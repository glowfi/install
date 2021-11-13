#!/bin/sh

# CORE PACAKAGES
sudo pacman -S --noconfirm xorg-server xorg-xinit xorg-xrandr xorg-xsetroot 
sudo pacman -S --noconfirm pulsemixer pamixer
sudo pacman -S --noconfirm lxrandr brightnessctl picom feh xdg-user-dirs xdg-utils  
sudo pacman -S --noconfirm mtpfs gvfs-mtp
yay -S --noconfirm jmtpfs 

# APPEARANCE
sudo pacman -S --noconfirm lxappearance breeze-icons breeze-gtk breeze ttf-joypixels
yes | yay -S libxft-bgra

# SETUP DXHD

yay -S --noconfirm dxhd-bin
mkdir -p ~/.config/dxhd
mv ~/install/configs/dxhd/dxhd_dwm.sh ~/.config/dxhd
mv ~/.config/dxhd/dxhd_dwm.sh ~/.config/dxhd/dxhd.sh


# WALLPAPER SCRIPT 
touch ~/.wall.sh
echo '#!/bin/bash
while true;
do
    feh --bg-fill "$(find $HOME/wall -type f -name '*.jpg' -o -name '*.png' | shuf -n 1)"
    sleep 900s
done &
' >> ~/.wall.sh


# PIPEWIRE SCRIPT 
touch ~/.pw.sh
echo "#!/bin/sh
/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/pipewire-media-session
" >> ~/.pw.sh

# XINIT SETUP 
cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed -i '51,55d' ~/.xinitrc

echo "# Resolution
xrandr --output eDP-1 --mode 1336x768 &

# Picom 
picom -f &

# Hotkey daemon
dxhd -b &

# Pipewire
sh ~/.pw.sh &

# Wallpaper
sh ~/.wall.sh &

# dwm-bar
~/dwm-bar/dwm_bar.sh &

# Infinte loop
while true;do 
    dwm >/dev/null 2>&1 
done

# DWM Execute
exec dwm
" >> ~/.xinitrc


# INSTALL DWM 
cd ~/install/configs/dwm-6.2
sudo make clean install
cd ..

# INSTALL DEMNU
cd ~/install/configs/dmenu
sudo make clean install
cd ..

# INSTALL TOPBAR
cp -r ~/install/configs/dwm-bar ~
cd
