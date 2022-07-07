FROM  php:7.4-fpm-alpine as php_base

RUN apk --update --no-cache add \
  nginx \
  wget \
  curl \
  git \
  grep \
  build-base \
  cmake \
  file \
  libmemcached-dev \
  libmcrypt-dev \
  libxml2-dev \
  imagemagick-dev \
  pcre-dev \
  libc-dev \
  pkgconf \
  libtool \
  make \
  autoconf \
  g++ \
  cyrus-sasl-dev \
  libgsasl-dev \
  freetype-dev \
  libjpeg-turbo-dev \
  libzip-dev \
  libpng-dev \
  icu-dev \
  supervisor \
  autoconf \
  libc6-compat \
  gettext-dev \
  imap-dev \
  libxslt-dev \
  openssh-client \
  ca-certificates \
  bash

# RUN apk apk update
# RUN apk add php7-simplexml-7.1.5-r0

RUN docker-php-ext-install -j8 gd intl pdo_mysql mysqli xsl soap bcmath opcache xmlrpc zip

RUN pecl channel-update pecl.php.net \
     && pecl install redis \
     && docker-php-ext-enable redis




FROM php_base
# disable root login
RUN sed -i -e 's/^root::/root:!:/' /etc/shadow

ADD ./config/php.ini /usr/local/etc/php/php.ini
ADD ./config/nginx.conf /etc/nginx/nginx.conf
ADD ./config/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN mkdir /etc/periodic/everymin
ADD ./config/cron-root /etc/crontabs/root
RUN chmod 0600 /etc/crontabs/root
ADD ./config/scheduler /etc/periodic/hourly/scheduler
RUN chmod 0644 /etc/periodic/hourly/scheduler

RUN rm -rf /var/www && rm /etc/nginx/http.d/default.conf
ADD ./config/moodle.conf /etc/nginx/http.d/moodle.conf
ADD ./moodle /var/www/moodle
ADD ./config/config.php /var/www/moodle/config.php
RUN chown -R nginx:nginx /var/www/moodle
RUN mkdir /moodledata
RUN chown -R www-data:www-data /moodledata

ADD ./config/scheduler-supervisord.conf /etc/supervisord.conf
ADD ./config/start.sh /start.sh

EXPOSE 80

ENTRYPOINT ["/bin/sh", "/start.sh"]
