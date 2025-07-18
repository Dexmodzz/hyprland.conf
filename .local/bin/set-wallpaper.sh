#!/bin/bash

WALL_DIR="$HOME/Pictures/Wallpapers"

# Controlla che esista la cartella
if [ ! -d "$WALL_DIR" ]; then
  echo "Cartella wallpapers non trovata: $WALL_DIR"
  exit 1
fi

# Prendi lista immagini jpg/png
FILES=()
BASENAMES=()
while IFS= read -r -d $'\0' f; do
  FILES+=("$f")
  BASENAMES+=("$(basename "$f")")
done < <(find "$WALL_DIR" -maxdepth 1 \( -iname '*.jpg' -o -iname '*.png' \) -print0)

if [ ${#FILES[@]} -eq 0 ]; then
  echo "Nessuna immagine trovata in $WALL_DIR"
  exit 1
fi

# Costruisci la lista per rofi con nomi e icone (anteprime)
ROFI_LIST=""
for i in "${!BASENAMES[@]}"; do
  ROFI_LIST+="${BASENAMES[i]}\0icon\x1f${FILES[i]}\n"
done

# Mostra rofi con icone
SELECTED=$(echo -en "$ROFI_LIST" | rofi -dmenu -i -p "Scegli wallpaper:" -show-icons)

if [ -z "$SELECTED" ]; then
  echo "Nessuna immagine selezionata"
  exit 0
fi

# Trova l’indice selezionato per prendere il percorso
INDEX=-1
for i in "${!BASENAMES[@]}"; do
  if [[ "${BASENAMES[i]}" == "$SELECTED" ]]; then
    INDEX=$i
    break
  fi
done

if [ $INDEX -eq -1 ]; then
  echo "Selezione non valida"
  exit 1
fi

FILEPATH="${FILES[INDEX]}"

# Uccidi swaybg precedente e imposta nuovo sfondo
pkill swaybg 2>/dev/null
swaybg -o '*' -i "$FILEPATH" -m fill &

echo "Wallpaper impostato: $FILEPATH"
