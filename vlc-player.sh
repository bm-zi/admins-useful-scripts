#!/bin/bash
# play songs in musics directory via vlc player
# vlc player must be installed!

#   vlc -I dummy ~/2019/musics/melodies/$1

clear

MYDIR='~/musics/melodies/'

unset options i
while IFS= read -r -d $'\0' f; do
  options[i++]="$f"
done < <(find $MYDIR -maxdepth 1 -type f -print0 )

echo $MYDIR
select opt in "${options[@]}" "Stop the script"; do
  case $opt in
    *.mp3)
      echo; echo "Selected mp3 file:   $(basename -- $opt)"
      vlc -I dummy $opt --repeat 2&>/dev/null
      ./$(basename "$0") && exit
      echo
      ;;
    "Stop the script")
      echo "You chose to stop"
      break
      ;;
    *)
      echo "This is not in the list."
      ;;
  esac
done
