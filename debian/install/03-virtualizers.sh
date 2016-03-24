#!/bin/sh

[ "$(id -u)" = "0" ] && { echo "ERROR: Do not run as root"; exit 1; }
[ -f /usr/bin/sudo ] || { echo "ERROR: Install sudo first"; exit 1; }

sudo apt-get install -y linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,') \
                        virtualbox \
                        virtualbox-dkms \
                        virtualbox-guest-additions-iso

sudo modprobe vboxdrv

vagrant plugin install vagrant-vbguest

sudo apt-get install -y bridge-utils \
                        libvirt-bin \
                        qemu-kvm \
                        virt-manager \
                        virtinst
