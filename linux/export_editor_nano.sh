#!/bin/bash
#export EDITOR=nano

# Funktion zum Überprüfen und Hinzufügen der Umgebungsvariable EDITOR
add_editor_to_file() {
    local file=$1
    local editor_export="export EDITOR=nano"

    # Prüfen, ob die Datei existiert und ob die Umgebungsvariable bereits gesetzt ist
    if [[ -f $file ]]; then
        if grep -q "$editor_export" "$file"; then
            echo "Der Eintrag '$editor_export' ist bereits in $file vorhanden."
        else
            echo "$editor_export" >> "$file"
            echo "Der Eintrag '$editor_export' wurde zu $file hinzugefügt."
        fi
    else
        echo "Die Datei $file existiert nicht."
    fi
}

# Shell-Startdateien überprüfen
if [[ -n $BASH_VERSION ]]; then
    add_editor_to_file "$HOME/.bashrc"
    add_editor_to_file "$HOME/.bash_profile"
elif [[ -n $ZSH_VERSION ]]; then
    add_editor_to_file "$HOME/.zshrc"
else
    echo "Unbekannte Shell. Bitte überprüfen Sie Ihre Shell-Startdateien manuell."
fi
