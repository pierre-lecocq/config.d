#!/bin/sh

[ "$(id -u)" = "0" ] && { echo "ERROR: Do not run as root"; exit 1; }
[ -f /usr/bin/sudo ] || { echo "ERROR: Install sudo first"; exit 1; }

sudo apt-get build-dep -y emacs25

sudo apt-get install -y at-spi2-core \
     aspell \
     aspell-en \
     aspell-fr \
     fonts-inconsolata \
     git \
     mailutils \
     texi2html \
     texify \
     texinfo \
     texlive \
     texlive-base \
     texlive-generic-recommended \
     texlive-latex-base \
     texlive-latex-extra \
     w3m

git clone --depth=1 git://git.savannah.gnu.org/emacs.git $HOME/emacs.src
cd $HOME/emacs.src && ./autogen.sh && ./configure && make && sudo make install
