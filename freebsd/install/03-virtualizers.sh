#!/bin/sh

[ "$(id -u)" = "0" ] && { echo "ERROR: Do not run as root"; exit 1; }
[ -f /usr/bin/sudo ] || { echo "ERROR: Install sudo first"; exit 1; }

sudo pkg install -y virtualbox-ose \
                    virtualbox-ose-additions \
                    virtualbox-ose-kmod

sudo sh -c 'echo "vboxdrv_load=\"YES\"" > /boot/loader.conf'
sudo sh -c 'echo "vboxnet_enable=\"YES\"" > /etc/rc.conf'
