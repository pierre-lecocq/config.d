#!/bin/sh

[ "$(id -u)" = "0" ] && { echo "ERROR: Do not run as root"; exit 1; }
[ -f /usr/bin/sudo ] || { echo "ERROR: Install sudo first"; exit 1; }

sudo sed -i s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/ /etc/default/grub
sudo update-grub

if ! [ -f /etc/apt/sources.list.ori ]; then
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.ori
    sudo sh -c 'dpkg -l > /etc/apt/pkg.list.ori'
fi

sudo sed -e 's/jessie/stretch/ig' -i /etc/apt/sources.list
sudo sed -e 's/ main$/ main contrib non-free/g' -i /etc/apt/sources.list
sudo sh -c 'echo "APT::Install-Recommends \"0\";" > /etc/apt/apt.conf.d/50norecommends'

sudo apt-get update
sudo apt-get dist-upgrade

sudo apt-get autoremove --purge -y portmap rpcbind cups
