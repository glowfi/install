#!/bin/sh

# OS name
awk 'NR==1{print $1 " " $2}' /etc/*release

# Kernel version
uname -r

# Total packages installed
pacman -Q | wc -l

# Default user shell
echo "$SHELL"

# Desktop environment/Window manager
echo $XDG_CURRENT_DESKTOP

# Calulate the uptime
upSeconds="$(cat /proc/uptime | grep -o '^[0-9]\+')"
upMins=$((${upSeconds} / 60))
echo "${upSeconds} ${upMins}"
