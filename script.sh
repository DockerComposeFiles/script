#!/bin/bash

# Funktion zur Erkennung der Linux-Distribution
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case $ID in
            ubuntu)
                echo "ubuntu"
                ;;
            debian)
                echo "debian"
                ;;
            fedora)
                echo "fedora"
                ;;
            centos)
                echo "centos"
                ;;
            redhat)
                echo "redhat"
                ;;
            arch)
                echo "arch"
                ;;
            opensuse)
                echo "opensuse"
                ;;
            manjaro)
                echo "manjaro"
                ;;
            gentoo)
                echo "gentoo"
                ;;
            mint)
                echo "linuxmint"
                ;;
            *)
                echo "unknown"
                ;;
        esac
    elif type lsb_release >/dev/null 2>&1; then
        lsb_release -si | tr '[:upper:]' '[:lower:]'
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        echo $DISTRIB_ID | tr '[:upper:]' '[:lower:]'
    elif [ -f /etc/debian_version ]; then
        echo "debian"
    elif [ -f /etc/redhat-release ]; then
        echo "redhat"
    else
        echo "unknown"
    fi
}

# Hauptfunktion
main() {
    distro=$(detect_distro)

    echo "Erkannte Distribution: $distro"

    # Pfad zum Skript basierend auf der Distribution
    script="./${distro}.sh"

    if [ -f "$script" ]; then
        echo "Ausführen von $script..."
        chmod +x "$script"
        "$script"
    else
        echo "Kein Skript gefunden für Distribution: $distro"
        exit 1
    fi
}

main
