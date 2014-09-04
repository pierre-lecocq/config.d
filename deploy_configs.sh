#!/bin/sh

create_dir()
{
    if ! [ -d $1 ]; then
        echo " - creating $1"
        mkdir -p $1
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

create_dir ~/.mail
create_dir ~/work/src
create_dir ~/work/doc

create_link $curdir/dotfiles/gitconfig ~/.gitconfig
create_link $curdir/dotfiles/bashrc ~/.bashrc
create_link $curdir/dotfiles/bashrc_profile ~/.bashrc_profile
# create_link $curdir/dotfiles/xmodmap ~/.xmodmap
create_link $curdir/dotfiles/gtkrc-2.0 ~/.gtkrc-2.0

create_dir ~/.config
# create_link $curdir/dotfiles/conkyrc ~/.config/conkyrc
# create_link $curdir/dotfiles/openbox ~/.config/openbox
create_link $curdir/dotfiles/tint2 ~/.config/tint2
create_link $curdir/dotfiles/i3 ~/.config/i3
create_link $curdir/dotfiles/i3status ~/.config/i3status
create_link $curdir/dotfiles/dunst ~/.config/dunst
create_link $curdir/dotfiles/user-dirs.dirs ~/.config/user-dirs.dirs

create_link $curdir/bin ~/work/bin
chmod 700 ~/work/bin/*

cp -R $curdir/images ~/images
