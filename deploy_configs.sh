#!/bin/sh

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

curdir=`pwd`

create_link $curdir/gitconfig ~/.gitconfig
create_link $curdir/bashrc ~/.bashrc
create_link $curdir/bashrc_profile ~/.bashrc_profile
create_link $curdir/xmodmap ~/.xmodmap
create_link $curdir/emacs.d ~/.emacs.d
create_link $curdir/gtkrc-2.0 ~/.gtkrc-2.0

create_dir ~/.config
create_link $curdir/gtk-3.0 ~/.config/gtk-3.0
create_link $curdir/conkyrc ~/.config/conkyrc
create_link $curdir/openbox ~/.config/openbox
create_link $curdir/tint2 ~/.config/tint2
create_link $curdir/i3 ~/.config/i3
create_link $curdir/i3status ~/.config/i3status
create_link $curdir/dunst ~/.config/dunst

create_link $curdir/bin ~/bin
chmod 700 ~/bin/*

cp -R $curdir/images ~/images
