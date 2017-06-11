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
    php7-fpm

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    composer self-update

RUN composer global require "laravel/lumen-installer"

RUN ln -s /root/.composer/vendor/bin/lumen /bin/lumen

EXPOSE 9000
