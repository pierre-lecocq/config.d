#!/bin/sh

[ "$(id -u)" = "0" ] && { echo "ERROR: Do not run as root"; exit 1; }
[ -f /usr/bin/sudo ] || { echo "ERROR: Install sudo first"; exit 1; }

sudo apt-get install -y aspell \
                        aspell-en \
                        aspell-fr \
                        autoconf \
                        automake \
                        build-essential \
                        clang \
                        clamav \
                        cmake \
                        curl \
                        fail2ban \
                        gcc \
                        gdb \
                        gettext \
                        git \
                        gnupg \
                        gnupg-agent \
                        gnutls-bin \
                        irb \
                        john \
                        libncurses5-dev \
                        libruby \
                        linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,') \
                        locales \
                        mailutils \
                        manpages-dev \
                        mg \
                        mutt \
                        netcat \
                        nmap \
                        p7zip \
                        python \
                        rsync \
                        ruby \
                        ruby-dev \
                        rubygems \
                        sbcl \
                        siege \
                        sqlmap \
                        strace \
                        tcpdump \
                        tree \
                        unrar \
                        unzip \
                        valgrind \
                        wget \
                        yasm \
                        zip

mv $HOME/.bashrc $HOME/.bashrc.ori
# mv $HOME/.bash_profile $HOME/.bash_profile.ori

ln -s $HOME/src/config.d/config/gitconfig $HOME/.gitconfig
ln -s $HOME/src/config.d/config/gemrc $HOME/.gemrc
ln -s $HOME/src/config.d/config/bashrc $HOME/.bashrc
# ln -s $HOME/src/config.d/config/bash_profile $HOME/.bash_profile

ln -s $HOME/src/config.d/bin $HOME/bin
chmod 700 $HOME/bin/*

mkdir -p $HOME/src/lisp/systems
curl -O https://common-lisp.net/project/asdf/asdf.lisp
mv asdf.lisp $HOME/src/lisp/systems/

curl -O https://beta.quicklisp.org/quicklisp.lisp
mv quicklisp.lisp $HOME/
cd ~/
sbcl --load $HOME/quicklisp.lisp \
     --eval "(quicklisp-quickstart:install)" \
     --eval "(ql:quickload \"quicklisp-slime-helper\")" \
     --eval "(ql:add-to-init-file)" \
     --eval "(quit)"
rm -f $HOME/quicklisp.lisp
