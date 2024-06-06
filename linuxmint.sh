#!/bin/bash

# Backup der vorhandenen ~/.bashrc Datei erstellen
cp ~/.bashrc ~/.bashrc.backup

# Aliases hinzufügen
echo "
# Nützliche Aliases
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
" >> ~/.bashrc

# Anwenden der Änderungen
source ~/.bashrc

echo "Die Aliases wurden erfolgreich zur ~/.bashrc hinzugefügt und aktiviert."
