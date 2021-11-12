#!/bin/sh

# A dwm_bar module to display the current backlight brighness with xbacklight
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: xbacklight

dwm_backlight () {
    output=$(brightnessctl | head -2 | tail -1|xargs|cut -d '(' -f2 | cut -d ')' -f1)
    printf "%s☀ %.0f%s\n" "$SEP1" "$output" "$SEP2"
}

dwm_backlight
