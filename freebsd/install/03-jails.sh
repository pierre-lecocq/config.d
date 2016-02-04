#!/bin/sh

[ "$(id -u)" = "0" ] && { echo "ERROR: Do not run as root"; exit 1; }
[ -f /usr/local/bin/sudo ] || { echo "ERROR: Install sudo first"; exit 1; }

[ -f /home/jails ] || sudo mkdir /home/jails
sudo chown $USER:$USER /home/jails

sudo pkg install -y ezjail
sudo sh -c 'echo "ezjail_jaildir=/home/jails" >> /usr/local/etc/ezjail.conf'
sudo sh -c 'echo "ezjail_enable=\"YES\"" >> /etc/rc.conf'

sudo ezjail-admin update -p -i
sudo ezjail-admin install

sudo ezjail-admin create -r /home/jails/www.jail.com www.jail.com 192.168.1.150
sudo sh -c 'echo "export jail_www_jail_com_hostname=\"www.jail.com\"" >> /usr/local/etc/ezjail/www_jail_com'
sudo sh -c 'echo "export jail_www_jail_com_ip=\"192.168.1.150\"" >> /usr/local/etc/ezjail/www_jail_com'

sudo ezjail-admin create -r /home/jails/sql.jail.com sql.jail.com 192.168.1.151
sudo sh -c 'echo "export jail_sql_jail_com_hostname=\"sql.jail.com\"" >> /usr/local/etc/ezjail/sql_jail_com'
sudo sh -c 'echo "export jail_sql_jail_com_ip=\"192.168.1.151\"" >> /usr/local/etc/ezjail/sql_jail_com'

# http://www.cyberciti.biz/faq/howto-setup-freebsd-jail-with-ezjail/
