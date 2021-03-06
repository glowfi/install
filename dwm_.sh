#!/bin/sh

# CORE PACAKAGES
sudo pacman -S --noconfirm xorg-server xorg-xinit xorg-xrandr xorg-xsetroot xautolock 
sudo pacman -S --noconfirm pulsemixer pamixer
sudo pacman -S --noconfirm lxrandr brightnessctl picom feh xdg-user-dirs xdg-desktop-portal-kde xdg-utils  
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
picom -f --experimental-backends --backend glx &

# Hotkey daemon
dxhd -b &

# Pipewire
sh ~/.pw.sh &

# Wallpaper
sh ~/.wall.sh &

# Autolock
xautolock -time 5 -locker slock &

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
sudo cp config.def.h config.h
sudo make clean install
cd ..

# INSTALL DEMNU
cd ~/install/configs/dmenu
sudo make clean install
cd ..

# INSTALL SLOCK
cd ~/install/configs/slock
vim ~/install/configs/slock/config.def.h
sudo mv ~/install/configs/slock/slock@.service /etc/systemd/system/slock@.service
sudo cp config.def.h config.h
sudo make clean install
sudo systemctl enable slock@john.service
cd ..

# INSTALL TOPBAR
cp -r ~/install/configs/dwm-bar ~
cd

# UPDATE MIMETYPE
touch ~/zathura.desktop
sudo touch zathura.desktop
cp -r ~/install/configs/zathura ~/.config

sudo echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Zathura
Comment=A minimalistic PDF viewer
Comment[de]=Ein minimalistischer PDF-Betrachter
Exec=zathura %f
Terminal=false
Categories=Office;Viewer;
MimeType=application/pdf;
" >> ~/zathura.desktop
sudo mv ~/zathura.desktop /usr/share/applications


xdg-mime default sxiv.desktop image/png
xdg-mime default sxiv.desktop image/jpg
xdg-mime default sxiv.desktop image/jpeg
xdg-mime default zathura.desktop application/pdf

