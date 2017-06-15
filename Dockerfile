FROM alpine:latest

MAINTAINER Ricardo Monteiro e Lima <ricardolima89@gmail.com>

RUN apk add --update --upgrade bash git curl

RUN apk add php7 \
    #REQUIRED BY COMPOSER
    php7-json \
    #REQUIRED BY COMPOSER
    php7-phar \
    #REQUIRED BY COMPOSER
    php7-iconv \
    #REQUIRED BY COMPOSER
    php7-openssl \
    #REQUIRED BY COMPOSER
    php7-zlib \
    #REQUIRED BY COMPOSER iconv operations
    php7-mbstring \
    #REQUIRED BY LUMEN
    php7-zip \
    #REQUIRED BY LUMEN & ARTISAN (migrate)
    php7-pdo \
    #REQUIRED BY LUMEN & ARTISAN (migrate)
    php7-memcached \
    #REQUIRED BY LUMEN & ARTISAN (migrate)
    php7-pdo_mysql \
    php7-fpm

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    composer self-update

RUN composer global require "laravel/lumen-installer"

RUN ln -s /root/.composer/vendor/bin/lumen /bin/lumen

#MAKE PHP-FPM LISTEN TO REQUESTS COMING FROM DOCKER NETWORK
RUN sed -i -e 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php7/php-fpm.d/www.conf

#PHP FPM PROCESS MUST RUN ON USER FOR LOG FILE WRITING PERMISSION
RUN adduser -S php
USER php

EXPOSE 9000
