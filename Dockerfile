FROM unblibraries/nginx:alpine
MAINTAINER Jacob Sanford <jsanford_at_unb.ca>

ENV COMPOSER_PATH /usr/local/bin
ENV PHP_FPM_ERROR_LOG /proc/self/fd/2
ENV PHP_PID_DIR /var/run/php

RUN apk --update add php5-fpm php5-json php5-zlib php5-xml php5-phar php5-gd php5-iconv php5-mcrypt curl php5-curl php5-openssl && \
  rm -f /var/cache/apk/* && \
  mkdir -p ${PHP_PID_DIR}/ && \
  chown ${NGINX_RUN_USER}:${NGINX_RUN_GROUP} ${PHP_PID_DIR}/ && \
  curl -sS https://getcomposer.org/installer | php -- --install-dir=${COMPOSER_PATH} --filename=composer

COPY conf/nginx/app.conf /etc/nginx/conf.d/app.conf
COPY conf/php/php.ini /etc/php5/php.ini
COPY conf/php/php-fpm.conf /etc/php5/php-fpm.conf

COPY scripts /scripts
RUN chmod -R 755 /scripts
