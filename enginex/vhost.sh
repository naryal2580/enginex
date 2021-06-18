#!/bin/sh

hostip=$(cat /hostip)

main() {
	echo "[INFO] Proxy IP: $hostip"

	echo -n "[INPUT] Domain name: "
	read domain

	echo "[INFO] Domain name: $domain"

	echo -n "[INPUT] Proxy Port: "
	read port

	echo "[INFO] Proxy Port: $port"

	RAND_DIR="/tmp/$RANDOM"
	TMP_CONF="$RAND_DIR/$domain"
	mkdir $RAND_DIR

	sed "s/DOMAIN/$domain/g" /config_template/vhost > "$TMP_CONF.0"

	sed "s/HOSTIP/$hostip/g" "$TMP_CONF.0" > "$TMP_CONF.1"

	sed "s/PORT/$port/g" "$TMP_CONF.1" > "$TMP_CONF"

	echo "[INFO] CONFIG FILE [OPEN]"
	cat $TMP_CONF
	echo "[INFO] CONFIG FILE [CLOSE]"

	cp $TMP_CONF "/etc/nginx/conf.d/$domain.conf"

	rm -rf $RAND_DIR

	nginx -t
}

while :
do
	main
	echo -n "[INPUT] Do you still want to continue(y/N): "
	read cont
	if [[ $cont == "y" ]]; then
		:
	else
		break
	fi
done

nginx -t

nginx -s reload


# TODO: Would you like to have TLS/SSL certificate (making it HTTPS)
echo -n "[INPUT] Do you wanna get HTTPS? [NOTE: YOU SHOULD HAVE A VALID DOMAIN NAME.] (y/N): "
read cont
if [[ $cont == "y" ]]; then
	https
fi
