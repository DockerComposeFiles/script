#!/bin/bash
apt update

# Apt
## core
apt install git flatpak
## file
xargs sudo apt-get install -y < "./linux_mint/apt.list"

# flatpak
## core
#flatpak install -y --from=flathub <app>
flatpak install flathub com.obsproject.Studio
