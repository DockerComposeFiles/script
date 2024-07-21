#!/bin/bash

# Entfernen Sie alte Docker-Versionen und verwandte Pakete
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
  sudo apt-get remove -y $pkg
done

# Entfernen Sie die alte Docker-Quelle
sudo rm -f /etc/apt/sources.list.d/docker.list

# Aktualisieren Sie die Paketliste
sudo apt update

# Installieren Sie erforderliche Pakete
sudo apt install -y ca-certificates curl gnupg

# Erstellen Sie das Verzeichnis für die Schlüsselringe
sudo install -m 0755 -d /etc/apt/keyrings

# Laden Sie den Docker GPG-Schlüssel herunter und speichern Sie ihn
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Setzen Sie die Berechtigungen für den Schlüsselring
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Fügen Sie das Docker-Repository zur Paketquelle hinzu
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo $VERSION_CODENAME) stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

# Aktualisieren Sie die Paketliste erneut
sudo apt update

# Installieren Sie Docker-Pakete
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Überprüfen Sie die Docker-Installation
sudo docker --version && docker compose version

# Erstellen Sie die Docker-Gruppe und fügen Sie den aktuellen Benutzer hinzu
sudo groupadd docker
sudo usermod -aG docker $USER

# Hinweis für den Benutzer, sich abzumelden und erneut anzumelden
echo "Bitte melden Sie sich ab und erneut an, um die Änderungen wirksam zu machen."

# Führen Sie einen Docker-Test aus
docker run hello-world
