#!/bin/bash

# Backup der vorhandenen ~/.bashrc Datei erstellen
cp ~/.bashrc ~/.bashrc.backup

# Definieren Sie die Aliases
ALIASES_START="### entry start identification ###"
ALIASES_CONTENT="
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias update='sudo apt update && sudo apt upgrade'
alias install='sudo apt install'
alias remove='sudo apt remove'
alias grep='grep --color=auto'
alias df='df -h'
alias free='free -m'
alias ..='cd ..'
alias ...='cd ../..'
alias h='history'
alias j='jobs -l'
alias mkdir='mkdir -pv'
alias rmd='rm -r'
alias cpv='cp -v'
alias mvv='mv -v'
alias dus='du -sh * | sort -h'
"
ALIASES_END="### entry end identification ###"

if ! grep -q "$ALIASES_START" ~/.bashrc || ! grep -q "$ALIASES_END" ~/.bashrc; then
    {
        echo "$ALIASES_START"
        echo "$ALIASES_CONTENT"
        echo "$ALIASES_END"
    } >>~/.bashrc

    # Anwenden der Änderungen
    source ~/.bashrc

    echo "Die Aliases wurden erfolgreich zur ~/.bashrc hinzugefügt und aktiviert."
else
    echo "Die Aliases sind bereits in der ~/.bashrc vorhanden."
fi
