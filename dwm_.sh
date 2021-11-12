#!/bin/sh
pacman -S xorg-server xorg-xinit xorg-xrandr xorg-xsetroot picom nitrogen 
pacman -S xcompmgr xorg-xprop xorg-xdpyinfo xdotool xorg-xbacklight lxrandr

cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed '2,4d' ~/.xinitrc

echo "xrandr --output eDP-1 --mode 1336x768 &" >> ~/.xinitrc

echo "picom -f &"  >> ~/.xinitrc

echo "nitrogen --restore &" >> ~/.xinitrc

echo "exec dwm"  >> ~/.xinitrc



#!/bin/sh
while true;
do
    feh --bg-scale "$(find $HOME/.wallpaper -type f -name '*.jpg' -o -name '*.png' | shuf -n 1)"
    sleep 15s
done &
