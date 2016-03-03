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
                        emacs \
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
                        mutt-patched \
                        netcat \
                        nmap \
                        offlineimap \
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

ln -s $HOME/src/config.d/common/config/gitconfig $HOME/.gitconfig
ln -s $HOME/src/config.d/common/config/gemrc $HOME/.gemrc
ln -s $HOME/src/config.d/common/config/bashrc $HOME/.bashrc
# ln -s $HOME/src/config.d/common/config/bash_profile $HOME/.bash_profile

ln -s $HOME/src/config.d/common/bin $HOME/bin
chmod 700 $HOME/bin/*
