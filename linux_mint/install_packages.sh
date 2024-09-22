#!/bin/bash
apt update

# Apt
## core
apt install git flatpak
## file
#xargs sudo apt-get install -y < "./linux_mint/apt.list"

# flatpak
## core
#flatpak install flathub <app>
#flatpak install -y --from=flathub <app>
## file
xargs flatpak install -y --from=flathub < "./flatpak.list"
