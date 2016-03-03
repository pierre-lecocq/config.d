#!/bin/sh

[ "$(id -u)" = "0" ] && { echo "ERROR: Do not run as root"; exit 1; }
[ -f /usr/bin/sudo ] || { echo "ERROR: Install sudo first"; exit 1; }

sudo apt-get install -y alsa-oss \
                        alsa-tools \
                        alsa-utils \
                        alsamixergui \
                        arandr \
                        chromium \
                        compton \
                        dunst \
                        feh \
                        fonts-inconsolata \
                        i3 \
                        i3lock \
                        i3status \
                        libnotify-bin \
                        mirage \
                        notification-daemon \
                        numlockx \
                        orage \
                        rxvt-unicode-256color \
                        scrot \
                        suckless-tools \
                        tango-icon-theme \
                        thunar \
                        transmission-gtk \
                        ttf-bitstream-vera \
                        ttf-dejavu \
                        vlc \
                        xclip \
                        xorg \
                        xpdf

echo "exec i3" > $HOME/.xinitrc

Xorg -configure

mkdir -p $HOME/.config

ln -s $HOME/src/config.d/common/config/Xdefaults $HOME/.Xdefaults
ln -s $HOME/src/config.d/common/config/gtkrc-2.0 $HOME/.gtkrc-2.0
ln -s $HOME/src/config.d/common/config/gtk-3.0 $HOME/.gtk-3.0
ln -s $HOME/src/config.d/common/config/tint2 $HOME/.config/tint2
ln -s $HOME/src/config.d/common/config/i3 $HOME/.config/i3
ln -s $HOME/src/config.d/common/config/dunst $HOME/.config/dunst
ln -s $HOME/src/config.d/common/config/user-dirs.dirs $HOME/.config/user-dirs.dirs

ln -s $HOME/src/config.d/common/images $HOME/images
