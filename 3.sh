#!/bin/sh

# SYNCHRONIZING

sudo timedatectl set-ntp true
sudo hwclock --systohc
sudo reflector --verbose --country Germany -l 10 --protocol https,http --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy


# DISPLAY

sudo pacman -S --noconfirm xorg-server xf86-video-amdgpu


# DE

sudo pacman -S --noconfirm plasma-desktop plasma-workspace plasma-nm plasma-pa

sudo pacman -S --noconfirm breeze breeze-gtk kde-gtk-config kdecoration

sudo pacman -S --noconfirm powerdevil xdg-desktop-portal-kde

sudo pacman -S --noconfirm kwrited kwin kgamma5 khotkeys kinfocenter kscreen systemsettings sddm sddm-kcm


# AUR HELPER

git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin/
makepkg -si --noconfirm
cd ~
rm -rf yay-bin

# PACKAGES

### CORE
sudo pacman -S --noconfirm zip unzip unrar p7zip lzop
sudo pacman -S --noconfirm fish kitty imagemagick ttf-fantasque-sans-mono man-db
yes | sudo pacman -S alsa-utils alsa-plugins pipewire pipewire-alsa pipewire-pulse pipewire-jack
yay -S --noconfirm zramd dashbinsh nerd-fonts-fantasque-sans-mono

### CDX
sudo pacman -S --noconfirm postgresql redis python-pip gitui
yay -S --noconfirm mongodb-bin

### PACK
sudo pacman -S --noconfirm dolphin ark gwenview okular spectacle gimp
yay -S --noconfirm brave-bin gimp-plugin-registry onlyoffice-bin timeshift


# ENABLE ZRAM

sudo sed -i '8s/.*/MAX_SIZE=724/' /etc/default/zramd
sudo systemctl enable --now zramd

# ADD FEATURES TO pacman.conf

sudo sed -i 's/#Color/Color\nILoveCandy/' /etc/pacman.conf
sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf

# ADD FEATURES TO sudoers

sudo sed -i '71s/.*/Defaults insults/' /etc/sudoers

# REMOVE KWALLET

sudo rm -rf /usr/share/dbus-1/services/org.kde.kwalletd5.service

# ENABLE SDDM

sudo systemctl enable sddm

# SETUP APPARMOR

sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet lsm=landlock,lockdown,yama,apparmor,bpf"/' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo pacman -S --noconfirm apparmor
sudo systemctl enable --now apparmor.service

# SETUP DMENU

git clone https://git.suckless.org/dmenu
cd dmenu
sudo make install 
cd ..
rm -rf dmenu

# COPY FISH SHELL SETTINGS

fish -c "exit"
cp -r ~/install/configs/config.fish ~/.config/fish/

# INSTALL AND COPY NNN FM SETTINGS

git clone https://github.com/jarun/nnn
cd nnn
sudo make O_NERD=1 install
cd ..
rm -rf nnn

mkdir -p .config/nnn/plugins
cd .config/nnn/plugins/
curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh
sed -i 's/--paging=never --style="$BAT_STYLE" "$@" &/--theme=gruvbox-dark --paging=never --style="$BAT_STYLE" "$@" &/' ~/.config/nnn/plugins/preview-tui

# COPY KITTY SETTINGS

cp -r ~/install/configs/kitty ~/.config/

# REGISTER KITTY IN DOLPHIN

mkdir -p ~/.local/share/kservices5
cp -r ~/install/configs/kittyhere.desktop ~/.local/share/kservices5

# SETUP DXHD

yay -S --noconfirm dxhd-bin
mkdir -p ~/.config/dxhd
cp -r ~/install/configs/dxhd/dxhd.sh ~/.config/dxhd
mkdir -p ~/.config/systemd/user
cp -r ~/install/configs/dxhd/dxhd.service ~/.config/systemd/user
systemctl --user enable dxhd.service

# CHANGE DEFAULT SHELL

sudo usermod --shell /bin/fish john
