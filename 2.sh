#!/bin/sh

# SET LOCATION AND SYNCHRONIZE HARDWARE CLOCK

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc

# OPTIMIZE MAKEPKG

nc=$(grep -c ^processor /proc/cpuinfo)
echo "You have " $nc" cores."
echo "-------------------------------------------------"
echo "Changing the makeflags for "$nc" cores."
TOTALMEM=$(cat /proc/meminfo | grep -i 'memtotal' | grep -o '[[:digit:]]*')
if [[  $TOTALMEM -gt 8000000 ]]; then
sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$nc\"/g" /etc/makepkg.conf
echo "Changing the compression settings for "$nc" cores."
sed -i "s/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T $nc -z -)/g" /etc/makepkg.conf
fi

# LOCALE GENERATION

sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# SET HOSTNAME

echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

# SET USER

echo "What would be the username?"
read uname
echo "What would be the fullname of the user?"
read fname

echo root:password | chpasswd
useradd -mG wheel $uname
usermod -c "$fname" $uname
echo $uname:password | chpasswd
echo "$uname ALL=(ALL) ALL" >> /etc/sudoers.d/$uname


# PACAKGES

pacman -S --noconfirm grub efibootmgr ntfs-3g networkmanager network-manager-applet wireless_tools wpa_supplicant dialog mtools dosfstools reflector wget rsync

# RUST REPLACEMENTS OF SOME GNU COREUTILS (ls cat grep find top)

pacman -S --noconfirm exa bat ripgrep fd bottom

# GRUB

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg


# UPDATING mkinitcpio.conf

sed -i 's/MODULES=()/MODULES=(btrfs amdgpu)/' /etc/mkinitcpio.conf
mkinitcpio -p linux-zen


# ENABLE PACKAGES

systemctl enable NetworkManager
systemctl enable reflector.timer

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m\n"
