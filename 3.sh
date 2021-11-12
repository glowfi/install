#!/bin/sh

# SYNCHRONIZING

sudo timedatectl set-ntp true
sudo hwclock --systohc
sudo reflector --verbose --country Germany -l 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy

# ADD FEATURES TO pacman.conf

sudo sed -i 's/#Color/Color\nILoveCandy/' /etc/pacman.conf
sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf
sudo pacman -Syy

# DISPLAY

sudo pacman -S --noconfirm xorg-server xf86-video-amdgpu


# AUR HELPER

git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin/
makepkg -si --noconfirm
cd ~
rm -rf yay-bin

# PACKAGES

### CORE
sudo pacman -S --noconfirm zip unzip unrar p7zip lzop
sudo pacman -S --noconfirm fish kitty imagemagick ttf-fantasque-sans-mono man-db noto-fonts-emoji
yes | sudo pacman -S alsa-utils alsa-plugins pipewire pipewire-alsa pipewire-pulse pipewire-jack
yay -S --noconfirm zramd nerd-fonts-fantasque-sans-mono

### CDX
sudo pacman -S --noconfirm postgresql redis python-pip gitui github-cli
yay -S --noconfirm mongodb-bin

### PACK
# sudo pacman -S --noconfirm dolphin ark gwenview okular flameshot 
sudo pacman -S --noconfirm pacmanfm ark gwenview okular flameshot 
yay -S --noconfirm brave-bin onlyoffice-bin

### TERMINAL TOMFOOLERY
sudo pacman -S --noconfirm fortune-mod figlet lolcat cmatrix asciiquarium cowsay ponysay
yay -S --noconfirm toilet toilet-fonts
git clone https://github.com/xero/figlet-fonts
sudo cp -r figlet-fonts/* /usr/share/figlet/fonts
rm -rf figlet-fonts
git clone https://github.com/xorg62/tty-clock
cd tty-clock
sudo make clean install
cd ..
rm -rf tty-clock

### OPTIONAL
# sudo pacman -S --noconfirm gimp kdenlive ffmpeg ffmpegthumbs youtube-dl simplescreenrecorder mpv
# yay -S --noconfirm gimp-plugin-registry timeshift dashbinsh

# ENABLE ZRAM

sudo sed -i '8s/.*/MAX_SIZE=724/' /etc/default/zramd
sudo systemctl enable --now zramd

# ADD FEATURES TO sudoers

sudo sed -i '71s/.*/Defaults insults/' /etc/sudoers

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

sudo pacman -S --noconfirm trash-cli
git clone https://github.com/jarun/nnn
cd nnn
sudo make O_NERD=1 install
cd ..
rm -rf nnn

mkdir -p .config/nnn/plugins
cd .config/nnn/plugins/
curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh
sed -i '180 a                      --theme=gruvbox-dark --paging=never --style="$BAT_STYLE" "$@" &' ~/.config/nnn/plugins/preview-tui
sed -i '182d' ~/.config/nnn/plugins/preview-tui

# COPY KITTY SETTINGS

cp -r ~/install/configs/kitty ~/.config/

# CHANGE DEFAULT SHELL

sudo usermod --shell /bin/fish john
