#!/bin/bash

hist=~/.wallpaper.last

if ! [ -f $hist ]; then
    touch $hist
fi

files=(~/images/wallpapers/*)

while [ true ]; do
    file=${files[RANDOM % ${#files[@]}]}
    if ! [ `cat $hist` == "$file" ]; then
    echo $file > $hist
    break
    fi
done

feh --bg-scale $file &
