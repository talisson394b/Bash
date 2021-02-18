#! /usr/bin/env bash

MAIN_DIR="$HOME/Downloads"

IMAGEM=("$HOME/Pictures" '.jpg' '.png' '.jpeg' '.gif')
AUDIO=("$HOME/Music" '.mp3' '.m4a' '.wma')
VIDEO=("$HOME/Pictures" '.mp4' '.mkv')
DOCUMENTO=("$HOME/Documents" '.pdf')

# Verifica se o diretório principal contem algum arquivo
if [ $(ls -A $MAIN_DIR | wc -l) -eq 0 ]; then
    exit 0
fi



Main() {
    declare -a array=($@)
    local dir=${array[0]}

    [ -d $dir ] || mkdir $dir
    for ext in ${array[@]:1}; do
        find $MAIN_DIR -name "*$ext" -exec mv {} $dir \;
    done
}

Main ${IMAGEM[@]}
Main ${AUDIO[@]}
Main ${VIDEO[@]}
Main ${DOCUMENTO[@]}

