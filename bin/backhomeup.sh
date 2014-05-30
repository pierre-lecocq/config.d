#!/bin/bash

device=/dev/sdc1
volume=/media/usb
dest=$volume/backups/$USER/

mountpoint $volume > /dev/null
if [ $? -eq 0 ] ; then
    echo " [+] Device $device mounted at $volume point."
else
    echo " [+] Mounting device $device at $volume point ..."
    sudo mount $device $volume/
fi

echo " [+] Cleaning home directory ..."

sh $HOME/bin/autocleanhome.sh

if [ ! -d $dest ]; then
    echo " [+] Creating destination directory $dest ..."
    mkdir -p $dest
fi

echo " [+] Backing up home directory ..."

rsyncopts="-avh --delete --progress"

rsync $rsyncopts --exclude ".*" --exclude "vbox" --exclude "downloads" $HOME/ $dest
rsync $rsyncopts $HOME/.pro $dest
rsync $rsyncopts $HOME/.ssh $dest

echo " [+] Done."
