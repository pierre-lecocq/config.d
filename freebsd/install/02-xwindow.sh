#!/bin/sh

[ "$(id -u)" = "0" ] && { echo "ERROR: Do not run as root"; exit 1; }
[ -f /usr/local/bin/sudo ] || { echo "ERROR: Install sudo first"; exit 1; }

sudo pkg install -y arandr \
     chromium \
     dmenu \
     dunst \
     emacs-devel \
     feh \
     firefox \
     i3 \
     i3lock \
     i3status \
     icons-tango \
     inconsolata-ttf \
     rxvt-unicode \
     scrot \
     thunar \
     transmission-gtk \
     vlc \
     xorg \
     xpdf

[ -L $HOME/.Xdefaults ] || ln -s $HOME/src/config.d/common/config/Xdefaults $HOME/.Xdefaults
[ -L $HOME/.gtkrc-2.0 ] || ln -s $HOME/src/config.d/common/config/gtkrc-2.0 $HOME/.gtkrc-2.0
[ -L $HOME/.gtk-3.0 ] || ln -s $HOME/src/config.d/common/config/gtk-3.0 $HOME/.gtk-3.0
[ -L $HOME/.config/user-dirs.dirs ] || ln -s $HOME/src/config.d/common/config/user-dirs.dirs $HOME/.config/user-dirs.dirs

[ -f $HOME/.config ] || mkdir -p $HOME/.config
[ -L $HOME/.config/i3 ] || ln -s $HOME/src/config.d/common/config/i3 $HOME/.config/i3
[ -L $HOME/.config/tint2 ] || ln -s $HOME/src/config.d/common/config/tint2 $HOME/.config/tint2
[ -L $HOME/.config/dunst ] || ln -s $HOME/src/config.d/common/config/dunst $HOME/.config/dunst

[ -f $HOME/.xinitrc ] && mv $HOME/.xinitrc $HOME/.xinitrc.ori
echo "exec i3" > $HOME/.xinitrc

[ -L $HOME/.Xdefaults ] || ln -s $HOME/src/config.d/images $HOME/images
