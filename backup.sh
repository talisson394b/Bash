#! /usr/bin/env bash

ORIGIN="$HOME/Documents"
BACKUP="$HOME/Backups"
REGISTER="$BACKUP/.nomedia"


update() {
    local count=0
    for arch in "$ORIGIN"/*; do
        content="$BACKUP/$(basename $arch)"
        if ! [ -e $content ]; then
            cp -f $arch $BACKUP
	    ((count++))
        fi
    done
    echo $count
}


updateRegister() {
      local date="$(date '+ %d%m %H:%M ')"
      printf "%s\t%s\\n" "$date", "+$1" >> $REGISTER
}


cleanRegister() {
     echo -e "! nomedia $0 " > $REGISTER
}


getForFiles() {
    if [ $(ls $ORIGIN | wc -l) -ge 1 ]; then
        result=$(update)
	if [ $result -ne 0 ]; then
            updateRegister $result
            echo "NEW: +$result"
	fi
    fi
}


main() {
    if ! [ -d "$BACKUP" ]; then
        mkdir $BACKUP
	cleanRegister
    fi
    if ! [ -z "$1" ]; then
         case "$1" in
	     "-h"|"--help") echo "Ajuda"
	     ;;
	     "-c"|"--clear") cleanRegister
	     ;;
	     "-d"|"--compress") echo "Coprimir arquivos"
	 esac
    fi
    echo $(getForFiles)
}

main $@

