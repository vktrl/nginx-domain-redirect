#!/bin/bash
if [ -z "$NEW_DOMAIN" ] || [ -z "$OLD_DOMAIN" ]; then
	printf "You need to set them variables m8\n"
	exit 1
fi
if [ -z "$PORT" ]; then
    printf "Listening on default port 80\n"
    sed -i -e "s/{{PORT}}/80/g" /etc/nginx/nginx.conf
else
    printf "Listening on port $PORT"
    sed -i -e "s/{{PORT}}/${PORT}/g" /etc/nginx/nginx.conf
fi
if [ -z "$HTTP_STATUS" ]; then
    printf "Returning 301 by default\n"
    sed -i -e "s/{{HTTP_STATUS}}/301/g" /etc/nginx/nginx.conf
else
    printf "Returning $HTTP_STATUS"
    sed -i -e "s/{{HTTP_STATUS}}/${HTTP_STATUS}/g" /etc/nginx/nginx.conf
fi

sed -i -e "s/{{OLD_DOMAIN}}/${OLD_DOMAIN}/g" /etc/nginx/nginx.conf
sed -i -e "s/{{NEW_DOMAIN}}/${NEW_DOMAIN}/g" /etc/nginx/nginx.conf
sed -i -e "s/{{HTTP_STATUS}}/${HTTP_STATUS}/g" /etc/nginx/nginx.conf

printf "Redirecting from http(s)://(www.)${OLD_DOMAIN}/* to https://www.${NEW_DOMAIN}/\$1\n"

exec "$@"