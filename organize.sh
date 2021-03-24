#! /usr/bin/env bash

MAIN_DIR="$HOME/Downloads"


Property() {
   echo -e "
   "$HOME/Documents" "pdf" "html"\n
   "$HOME/Music" "mp3" "m4a" "wma"\n
   "$HOME/Movies" "mp4" "mkv"\n
   "$HOME/Pictures" "jpg" "png" "jpeg" "gif"
   "
}


Search() {
    local extension=$1
    grep "$extension" <<< $(Property)
}


Organize() {
    local target_directory=$1 extension=$2
    [ -d $target_directory ] || mkdir $target_directory
    find $MAIN_DIR -name "*[.]$extension" -exec mv {} $target_directory \;
}

Main() {
    local extension='' result=''
    for file in "$MAIN_DIR"/*; do
        extension="$(cut -f2 -d. <<< $file)
        result="$(Search $extension)"

	if [ -e $file ] && ! [ -z $extension ]; then
	    declare -a CLASS=$result
	    Organize ${CLASS[0]} $extension 
	fi
   done
}

if [ $( wc -l <<< $(ls -A $MAIN_DIR)) -eq 0 ]; then
    exit 0
fi

Main
