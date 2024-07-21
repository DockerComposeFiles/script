#!/bin/bash

./init/set_permission.sh

# Funktion zum Sammeln von Skripten aus einem Verzeichnis
collect_scripts() {
  local dir="$1"
  for script in "$dir"/*.sh; do
    # Prüfe, ob das Skript existiert
    if [ -f "$script" ]; then
      options+=("$script")
    fi
  done
}

# Array zum Speichern der Skriptnamen
options=()
# Füge Skripte aus dem aktuellen Verzeichnis hinzu
for script in *.sh; do
  # Ausschließen des eigenen Skripts aus den Optionen
  if [ "$script" != "${0##*/}" ]; then
    options+=("$script")
  fi
done

# Prüfe das Betriebssystem und füge entsprechende Skripte hinzu
collect_scripts "docker"
if [[ "$(uname)" == "Linux" ]]; then
  collect_scripts "linux"
fi
if [[ "$(lsb_release -is 2>/dev/null)" == "Ubuntu" ]]; then
  collect_scripts "ubuntu"
fi
if [[ "$(lsb_release -is 2>/dev/null)" == "Linuxmint" ]]; then
  collect_scripts "linux_mint"
fi

# Füge die Option "Beenden" hinzu
options+=("Beenden")

# Position des aktuellen Cursors
cursor=0

# Funktion zum Zeichnen des Menüs
draw_menu() {
  clear
  for i in "${!options[@]}"; do
    if [ $i -eq $cursor ]; then
      echo -e "> \e[1;32m${options[$i]##*/}\e[0m"
    else
      echo "  ${options[$i]##*/}"
    fi
  done
}

# Funktion zur Verarbeitung der Benutzereingabe
handle_input() {
  read -s -n 1 key
  case $key in
    A) # Up Arrow
      ((cursor--))
      if [ $cursor -lt 0 ]; then
        cursor=$((${#options[@]} - 1))
      fi
      ;;
    B) # Down Arrow
      ((cursor++))
      if [ $cursor -ge ${#options[@]} ]; then
        cursor=0
      fi
      ;;
    "") # Enter Key
      return 0
      ;;
  esac
  return 1
}

# Hauptschleife
while true; do
  draw_menu
  handle_input
  if [ $? -eq 0 ]; then
    if [ "${options[$cursor]}" == "Beenden" ]; then
      echo "Beenden..."
      break
    else
      echo "Starte ${options[$cursor]}..."
      ./"${options[$cursor]}"
      read -p "Drücke eine beliebige Taste, um fortzufahren..."
    fi
  fi
done
clear
