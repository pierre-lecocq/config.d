#!/bin/sh

[ "$(id -u)" = "0" ] && { echo "ERROR: Do not run as root"; exit 1; }
[ -f /usr/local/bin/sudo ] || { echo "ERROR: Install sudo first"; exit 1; }

sudo pkg install -y bash \
     curl \
     emacs-nox11 \
     git \
     mg \
     nano \
     nmap \
     python \
     rsync \
     ruby \
     ruby21-gems \
     tree \
     wget

[ -f /usr/local/bin/bash ] || { echo "ERROR: Bash has not been installed"; exit 1; }
chsh -s /usr/local/bin/bash
[ -f $HOME/.profile ] && mv $HOME/.profile $HOME/.profile.ori;
echo ". ~/.bashrc" > $HOME/.profile;

[ -L $HOME/.bashrc ] || ln -s $HOME/src/config.d/common/config/bashrc $HOME/.bashrc
[ -L $HOME/.gemrc ] || ln -s $HOME/src/config.d/common/config/gemrc $HOME/.gemrc
[ -L $HOME/.gitconfig ] || ln -s $HOME/src/config.d/common/config/gitconfig $HOME/.gitconfig

[ -L $HOME/bin ] || ln -s $HOME/src/config.d/common/bin $HOME/bin
chmod 700 $HOME/bin/*

git clone https://github.com/pierre-lecocq/emacs.d $HOME/src/emacs.d
[ -L $HOME/.emacs.d ] || ln -s $HOME/src/emacs.d $HOME/.emacs.d
