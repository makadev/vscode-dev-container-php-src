#!/bin/bash

source /workspace/scripts/config.sh

if [[ ! -d "${PHP_SOURCE}" ]]; then
    ## clone if sources not installed
    /workspace/scripts/fetch-source.sh
fi

## change working dir to src path
cd ${PHP_SOURCE}

## create default configuration
./buildconf \
&& ./configure \
    --with-openssl \
    --with-kerberos \
    --with-system-ciphers \
    --with-external-pcre \
    --with-pcre-jit \
    --with-zlib \
    --enable-bcmath \
    --with-bz2 \
    --enable-calendar \
    --with-curl \
    --with-enchant \
    --enable-exif \
    --with-ffi \
    --enable-ftp \
    --enable-gd \
    --with-webp \
    --with-jpeg \
    --with-xpm \
    --with-freetype \
    --enable-gd-jis-conv \
    --with-gettext \
    --with-gmp \
    --with-mhash \
    --with-imap \
    --with-kerberos \
    --with-imap-ssl \
    --enable-intl \
    --enable-mbstring \
    --with-mysqli \
    --disable-huge-code-pages \
    --enable-pcntl \
    --with-pdo-mysql \
    --with-pdo-pgsql \
    --with-pgsql \
    --with-pspell \
    --with-readline \
    --with-mm \
    --enable-shmop \
    --with-snmp \
    --enable-soap \
    --enable-sockets \
    --with-sodium \
    --with-password-argon2 \
    --enable-sysvmsg \
    --enable-sysvsem \
    --enable-sysvshm \
    --with-tidy \
    --with-xsl \
    --with-zip \
    --enable-mysqlnd \
&& /usr/bin/make "-j${NRJOBS}"
