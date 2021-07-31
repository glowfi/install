#!/bin/sh

# SET LOCATION AND SYNCHRONIZE HARDWARE CLOCK

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc

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

echo root:password | chpasswd
useradd -mG wheel john
usermod -c "John Doe" john
echo john:password | chpasswd
echo "john ALL=(ALL) ALL" >> /etc/sudoers.d/john


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
