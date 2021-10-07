#!/bin/sh

### ENABLE 32 bit respository
sudo sed -i '94s/.*/[multilib]/' /etc/pacman.conf
sudo sed -i '95s/.*/Include = \/etc\/pacman.d\/mirrorlist/' /etc/pacman.conf
sudo pacman -Syyy


### BASE PACAKGES
sudo pacman -S --noconfirm lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader
sudo pacman -S --noconfirm wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader lutris steam

### ACO
sudo sed -i '5s/.*/RADV_PERFTEST=aco/' /etc/environment

### Feral Gamemode
sudo pacman -S --noconfirm meson systemd git dbus libinih
git clone https://github.com/FeralInteractive/gamemode.git
cd gamemode
git checkout 1.6.1
./bootstrap.sh
cd ..
rm -rf gamemode

### ProtonGE
mkdir -p ~/.steam/root/compatibilitytools.d
wget https://github.com/GloriousEggroll/proton-ge-custom/releases/download/6.18-GE-2/Proton-6.18-GE-2.tar.gz -O ~/Proton-VERSION.tar.gz
tar -xf ~/Proton-VERSION.tar.gz -C ~/.steam/root/compatibilitytools.d
rm -rf ~/Proton-VERSION.tar.gz
