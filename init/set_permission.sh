#!/bin/bash

function dir_permissions() {
    if [[ $# -lt 2 ]]; then
        echo "Fehler: Mindestens 2 Parameter erforderlich."
        return 1
    fi

    permission=$1
    if ! [[ $permission =~ ^[0-7]{3}$ ]]; then
        echo "Fehler: Ungültiges Berechtigungsformat für Verzeichnisse (z. B. 755)."
        return 1
    fi

    shift
    for folder in "$@"; do
        if [ -d "$folder" ]; then
            find "$folder" -type d -exec chmod "$permission" {} +
            echo "Berechtigungen für Verzeichnis '$folder' auf $permission gesetzt"
            # else
            # echo "Fehler: Verzeichnis '$folder' existiert nicht."
        fi
    done
}

function file_permissions() {
    if [[ $# -lt 2 ]]; then
        echo "Fehler: Mindestens 2 Parameter erforderlich."
        return 1
    fi

    permission=$1
    if ! [[ $permission =~ ^[0-7]{3}$ ]]; then
        echo "Fehler: '$permission' ist kein gültiges Berechtigungsformat für Dateien (z. B. 644)."
        return 1
    fi

    shift
    for file in "$@"; do
        count=$(find . -type f -name "$file" | wc -l)
        if [[ $count -gt 0 ]]; then
            find . -type f -name "$file" -exec chmod "$permission" {} \;
            # echo "$count '$file' auf $permission gesetzt"
            # else
            # echo "Fehler beim setzen von Berechtigungen: Keine Dateien mit dem Namen '$file' gefunden."
        fi
    done
}

file_permissions "755" "*.sh"
