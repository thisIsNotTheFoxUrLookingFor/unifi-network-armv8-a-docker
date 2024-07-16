#!/bin/bash
touch /var/spool/cron/crontabs/root
crontab -l > mycron
echo "0 0 * * * /usr/bin/certbot -q renew" >> mycron
crontab mycron
rm mycron
service start cron
apt update && apt upgrade
wget -O unifi.deb https://unifi-install.foxtrot.blog/unifi
dpkg -i unifi.deb
rm unifi.deb
if [ -e /config/run.sh ]
then
    echo "Running extra run script"
    sh /config/run.sh
else
    echo "Nothing further to run"
fi
/etc/init.d/unifi start
while true; do sleep infinity; done
