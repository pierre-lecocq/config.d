#!/bin/sh

curdir=`pwd`

create_dir()
{
    if ! [ -d $1 ]; then
        echo " - creating $1"
        mkdir $1
    else
        echo " - directory $1 already exists"
    fi
}

create_link()
{
    if ! [ -L $2 ]; then
        echo " - linking $2"
        ln -s $1 $2
    else
        echo " - link $2 already exists"
    fi
}

create_dir "~/.config"
create_link "$curdir/emacs.d" "~/.emacs.d"
create_link "$curdir/bin" "~/bin"

# TODO Add i3 & others ...
