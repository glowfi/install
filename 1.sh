#!/bin/sh

# SYNCHRONIZE

timedatectl set-ntp true
sed -i 's/#Color/Color\nILoveCandy/' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf
pacman -Syyy
reflector --verbose --country Germany -l 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# PARTITION

(
  echo n;
  echo ;
  echo ;
  echo +300M;
  echo ef00;
  echo n;
  echo ;
  echo ;
  echo ;
  echo ;
  echo c;
  echo 1;
  echo "EFI";
  echo c;
  echo 2;
  echo "Arch Linux";
  echo w;
  echo Y;
) | gdisk /dev/sda

# FORMAT

mkfs.fat -F32 /dev/sda1
mkfs.btrfs /dev/sda2


# MOUNT

mount /dev/sda2 /mnt
btrfs su cr /mnt/@
umount /mnt


mount -o noatime,compress-force=zstd,space_cache=v2,subvol=@ /dev/sda2 /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot


# BASE SETUP

pacstrap /mnt base base-devel linux-zen linux-zen-headers linux-firmware amd-ucode btrfs-progs git vim

# GENERATE UUID OF THE DISKS

genfstab -U /mnt >> /mnt/etc/fstab

# GO TO MAIN SYSTEM

arch-chroot /mnt
