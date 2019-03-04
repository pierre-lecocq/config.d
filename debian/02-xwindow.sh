#!/bin/sh

[ "$(id -u)" = "0" ] && { echo "ERROR: Do not run as root"; exit 1; }
[ -f /usr/bin/sudo ] || { echo "ERROR: Install sudo first"; exit 1; }

sudo apt-get install -y alsa-oss \
                        alsa-tools \
                        alsa-utils \
                        alsamixergui \
                        arandr \
                        chromium \
                        clementine \
                        compton \
                        conky \
                        dunst \
                        fakeroot \
                        feh \
                        fonts-font-awesome \
                        fonts-inconsolata \
                        i3 \
                        i3lock \
                        i3status \
                        libnotify-bin \
                        notification-daemon \
                        numlockx \
                        pavucontrol \
                        pulseaudio \
                        python-all \
                        python-pip \
                        python-stdeb \
                        rxvt-unicode-256color \
                        screenfetch \
                        scrot \
                        suckless-tools \
                        tango-icon-theme \
                        thunar \
                        ttf-bitstream-vera \
                        ttf-dejavu \
                        tty-clock \
                        vlc \
                        xclip \
                        xorg \
                        xpdf

echo "exec i3" > $HOME/.xinitrc

Xorg -configure

pip install wheel
pip install py3status
ln -s ~/.local/bin/py3status ~/bin/py3status

mkdir -p $HOME/.config

ln -s $HOME/src/config.d/config/Xdefaults $HOME/.Xdefaults
ln -s $HOME/src/config.d/config/gtkrc-2.0 $HOME/.gtkrc-2.0
ln -s $HOME/src/config.d/config/gtk-3.0 $HOME/.gtk-3.0
ln -s $HOME/src/config.d/config/tint2 $HOME/.config/tint2
ln -s $HOME/src/config.d/config/i3 $HOME/.config/i3
ln -s $HOME/src/config.d/config/dunst $HOME/.config/dunst
ln -s $HOME/src/config.d/config/user-dirs.dirs $HOME/.config/user-dirs.dirs

ln -s $HOME/src/config.d/images $HOME/images

fc-cache -fv
