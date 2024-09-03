sudo apt update

# core
sudo apt install remmina

#good
xargs sudo apt-get install -y < "./apt"

flatpak install -y --from=flathub remmina

apt list --installed
flatpak list