#!/bin/sh

main_menu()
{
    printf "\n"
    printf "\n * 1. Install basic system\n"
    printf " * 2. Install WM (i3wm)\n"
    printf " * 3. Install WM (Openbox)\n"
    printf " * 4. Install desktop apps\n"
    printf " * 5. Install Pentesting tools\n"
    printf " * 6. Install VirtualBox\n"
    printf " * 7. Install emacs from source\n"
    printf " * 0. Exit\n\n"
}

do_install_system() {
    printf "\nInstalling basic system...\n"

    sudo apt-get autoremove --purge -y exim4-.\* portmap rpcbind
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.ori
    sudo sed -e 's/ main$/ main contrib non-free/g' -i /etc/apt/sources.list

    sudo apt-get update

    sudo apt-get install -y \
        emacs \
        gnutls-bin \
        git \
        wget \
        curl \
        rsync \
        tree \
        htop \
        aria2 \
        irssi \
        secure-delete \
        gcc \
        gdb \
        build-essential \
        yasm \
        linux-headers-$(uname -r) \
        libxslt-dev \
        libxml2-dev \
        libncurses5-dev \
        irb \
        python \
        ruby \
        libruby \
        ruby-dev \
        rubygems \
        nmap \
        fail2ban \
        denyhosts \
        iotop \
        tcpdump \
        httperf \
        siege \
        iptraf \
        clamav

}

do_install_wm_i3wm() {
    printf "\nInstalling i3wm...\n"

    echo "exec i3" > ~/.xinitrc

    sudo apt-get update

    sudo apt-get install -y \
        xorg \
        i3 \
        i3lock


    Xorg -configure
}

do_install_wm_openbox() {
    printf "\nInstalling openbox...\n"

    echo "exec openbox-session" > ~/.xinitrc

    sudo apt-get update

    sudo apt-get install -y \
        xorg \
        openbox \
        obconf \
        obmenu \
        tint2 \
        xcompmgr \
        conky \
        grun \
        gksu \
        xscreensaver

    Xorg -configure
}

do_install_desktop_apps() {
    printf "\nInstalling desktop apps...\n"

    sudo apt-get update

    sudo apt-get install -y \
        arandr \
        feh \
        terminator \
        tango-icon-theme \
        suckless-tools \
        ttf-bitstream-vera \
        ttf-mscorefonts-installer \
        thunar \
        orage \
        libnotify-bin \
        notification-daemon \
        numlockx \
        tor \
        polipo \
        alsa \
        alsa-tools \
        alsa-oss \
        alsamixergui \
        chromium-browser \
        scrot \
        pidgin \
        xpdf \
        mirage \
        filezilla \
        transmission-gtk \
        vlc \
        flashplugin-nonfree

    sudo echo "proxyAddress = \"127.0.0.1\"" >> /etc/polipo/config
    sudo echo "proxyPort = 8118" >> /etc/polipo/config
    sudo echo "socksParentProxy = \"localhost:9050\"" >> /etc/polipo/config
    sudo echo "socksProxyType = socks5" >> /etc/polipo/config
    sudo echo "allowedClients = 127.0.0.1" >> /etc/polipo/config
    sudo /etc/init.d/tor restart
    sudo /etc/init.d/polipo restart
    # Then configure proxy to 127.0.0.1:8118
    # https://check.torproject.org/

    # alsactl init
}

install_pentesting() {
    printf "\nInstalling pentesting ...\n"

    sudo apt-get update

    sudo apt-get install -y \
        nmap \
        w3af \
        sqlmap \
        tcpdump \
        tcptrace \
        ettercap \
        dsniff \
        netcat \
        ngrep \
        john \
        kismet \
        siege \
        ratproxy \
        nikto \
        build-essential \
        subversion \
        ruby \
        libruby \
        irb \
        rdoc \
        libyaml-ruby \
        libzlib-ruby \
        libopenssl-ruby \
        libdl-ruby \
        libreadline-ruby \
        libiconv-ruby \
        rubygems \
        sqlite3 \
        libsqlite3-ruby \
        libsqlite3-dev \
        python-pycurl \
        python-beautifulsoup \
        python-libxml2 \
        python-geoip

    svn co http://www.metasploit.com/svn/framework3/trunk /usr/local/metasploit;
    ln -s /usr/local/metasploit/msfconsole /usr/local/bin/msfconsole

    svn co https://xsser.svn.sourceforge.net/svnroot/xsser /usr/local/xsser
    ln -s /usr/local/xsser/xsser /usr/local/bin/xsser
}

do_install_virtualbox() {
    printf "\nInstalling virtualbox ...\n"

    sudo apt-get update

    sudo apt-get install -y virtualbox-ose virtualbox-ose-dkms
}

do_install_emacs_from_source() {

    printf "\nInstalling emacs from source...\n"

    sudo apt-get update

    sudo apt-get install -y \
        wget \
        gcc \
        gdb \
        build-essential \
        yasm \
        linux-headers-$(uname -r) \
        git \
        bzr \
        libxslt-dev \
        libxml2-dev \
        libncurses5-dev \
        libgtk-3-dev \
        libcanberra-gtk3-dev \
        libgif-dev \
        libxpm-dev \
        libjpeg8-dev \
        libtiff5-dev

    # bzr branch bzr://bzr.savannah.gnu.org/emacs/trunk emacs.src
    # git clone git://git.savannah.gnu.org/emacs.git emacs.src
    wget ftp://ftp.gnu.org/pub/gnu/emacs/emacs-24.3.tar.xz && tar xvJf emacs-24.3.tar.xz && mv emacs-24.3 emacs.src

    cd emacs.src && ./configure --with-x-toolkit=gtk3 && make && sudo make install
}


do_exit() {
    printf "\nBye!\n\n"
    exit 0;
}

while true; do
    main_menu
    echo -n "What do you want to do ? "
    read CHOICE

    case "$CHOICE" in
        "1") do_install_system ;;
        "2") do_install_wm_i3wm ;;
        "3") do_install_wm_openbox ;;
        "4") do_install_desktop_apps ;;
        "5") do_install_pentesting ;;
        "6") do_install_virtualbox ;;
        "7") do_install_emacs_from_source ;;
        *) do_exit ;;
    esac
done
