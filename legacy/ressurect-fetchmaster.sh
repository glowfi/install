#!/bin/sh

# INSTALL FETCHMASTER

pip install tcolorpy
mkdir -p ~/.local/bin
cp -r ~/install/legacy/fetchmaster.py ~/.local/bin/
chmod +x ~/.local/bin/fetchmaster.py


# Fetchmaster alias
# alias fetchmaster="fetchmaster.py"
