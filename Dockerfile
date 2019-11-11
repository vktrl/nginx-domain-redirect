FROM nginx:alpine

RUN apk add --update bash \
	&& rm -rf /var/cache/apk/* \
  	&& ln -sf /dev/stdout ${LOG_PREFIX}/access.log \
	&& ln -sf /dev/stderr ${LOG_PREFIX}/error.log \
	&& ln -sf /dev/stdout ${LOG_PREFIX}/blocked.log

COPY docker-entrypoint.sh /
COPY nginx.conf /etc/nginx/nginx.conf

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]