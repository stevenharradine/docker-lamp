FROM alpine:3.6

# ensure www-data user exists
RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

RUN apk add --no-cache nginx \
                       php7 \
                       php7-fpm

RUN mkdir /data && \
    mkdir /data/www && \
    mkdir /data/www/docroot && \
    mkdir /run/nginx/ && \
    cat /etc/passwd

COPY default.conf /etc/nginx/conf.d/default.conf
COPY php-fpm.conf /etc/php7/php-fpm.conf
RUN echo "hello world!" > /data/www/docroot/index.php

RUN php-fpm7 -D

RUN ls -alsh /var/run/php-fpm.sock

CMD ["nginx", "-g", "daemon off;"]
