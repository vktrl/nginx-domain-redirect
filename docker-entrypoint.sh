#!/bin/bash
if [ -z "$NEW_DOMAIN" ] || [ -z "$OLD_DOMAIN" ]; then
	printf "You need to set them variables m8"
	exit 1
fi
if [ -z "$PORT" ]; then
    printf "Using default port 8080\n"
    sed -i -e "s/{{PORT}}/8080/g" /etc/nginx/nginx.conf
else
    sed -i -e "s/{{PORT}}/${PORT}/g" /etc/nginx/nginx.conf
fi

sed -i -e "s/{{OLD_DOMAIN}}/${OLD_DOMAIN}/g" /etc/nginx/nginx.conf
sed -i -e "s/{{NEW_DOMAIN}}/${NEW_DOMAIN}/g" /etc/nginx/nginx.conf

printf "Redirecting from http(s)://(www.)${OLD_DOMAIN}/* to https://${NEW_DOMAIN}/\$1\n"

exec "$@"