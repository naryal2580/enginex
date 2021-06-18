#!/bin/sh

# Some useful stuff
hostname=$(cat /hostname)
hostip=$(ip route show | awk '/default/ {print $3}')
echo $hostname > /etc/hostname
echo $hostip > /hostip


# Getting rid of a few defaults
NCONF="/etc/nginx/nginx.conf"
CONFD="/etc/nginx/conf.d"

sed '16a\    server_tokens off;' < $NCONF | tee $NCONF
sed "s/server_name  localhost/server_name $hostname/g" "$CONFD/default.conf" > "$CONFD/$hostname.conf"
rm "$CONFD/default.conf"


# Summing up!
ln -s /vhost.sh /bin/vhost

echo "certbot --nginx" > /bin/https

chmod a+x /bin/https

rm /main.sh

#nginx -g "daemon off;"
