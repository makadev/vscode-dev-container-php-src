# default container base
ARG SYSTEM=debian
ARG VARIANT=buster
## base container to be used
FROM ${SYSTEM}:${VARIANT}

## install git, toolchain and dev dependencies
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ## needed for source code checkout and commits from within container
    ## f.e. https, git+ssh, signing
    git ca-certificates openssl openssh-client gnupg2 \
    ## see https://github.com/php/php-src/tree/0fbebfd1ae3dfc8d9e088abbb6b062f5c86f2587#building-php-source-code
    ## build tools / toolchain and utils
    pkg-config \
    build-essential \
    autoconf \
    bison \
    re2c \
    ## coverage output generator
    lcov \
    ## should be installed with build-essentials, containing C standard headers and f.e. libiconv, libintl, ...
    # libc6-dev \
    ## file, needed/expected in configure script but preinstalled inside container
    file \
    ## ext/libxml, ext/xml, ext/xml*, ext/dom, ...
    libxml2-dev \
    ## ext/sqlite3, ext/pdo_sqlite and maybe others
    libsqlite3-dev \
    ## [OPTIONAL] memory leak detector valgrind
    valgrind \
    ## [OPTIONAL] llvm toolchain just in case
    clang lldb llvm \
    ## [OPTIONAL] extra locale for certain tests
    locales-all \
    ## cleanup apt list and everything we normally do not need in a container
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

## install optional dev dependencies
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ## [OPTIONAL] ext/mbstring support for mb regex via oniguruma
    libonig-dev \
    ## [OPTIONAL] kerberos support for ext/imap and maybe others
    libkrb5-dev \
    ## [OPTIONAL] ext/session mm support
    libmm-dev \
    ## [OPTIONAL] argon pw support for ext/standard, ext/sodium
    libargon2-dev \
    ## [OPTIONAL] ext/xsl
    libxslt-dev \
    ## [OPTIONAL] ext/tidy
    libtidy-dev \
    ## [OPTIONAL] ext/sodium
    libsodium-dev \
    ## [OPTIONAL] ext/snmp
    libsnmp-dev \
    ## [OPTIONAL] ext/readline via libreadline
    libreadline-dev \
    ## [OPTIONAL] ext/readline via libedit
    libedit-dev \
    ## [OPTIONAL] ext/pspell
    libpspell-dev \
    ## [OPTIONAL] ext/libpcre (not bundled)
    libpcre2-dev \
    ## [OPTIONAL] used by multiple modules like ext/ftp, ext/openssl
    libssl-dev \
    ## [OPTIONAL] sapi/mod_php
    apache2-dev \
    ## [OPTIONAL] ext/bz2
    libbz2-1.0 libbz2-dev \
    ## [OPTIONAL] ext/curl
    libcurl4 libcurl4-openssl-dev \
    ## [OPTIONAL] ext/zip
    libzip-dev \
    ## [OPTIONAL] used by multiple modules like ext/zlib, ext/gd (gd2)
    zlib1g-dev \
    ## [OPTIONAL] ext/pdo_pgsql
    libpq-dev \
    ## [OPTIONAL] ext/gd webp support
    libwebp-dev \
    ## [OPTIONAL] ext/gd jpeg support
    libjpeg62-turbo-dev \
    ## [OPTIONAL] ext/gd png support
    libpng-dev \
    ## [OPTIONAL] ext/gd xpm support
    libxpm-dev \
    ## [OPTIONAL] ext/gd freetype support
    libfreetype6-dev \
    ## [OPTIONAL] ext/enchant
    libenchant-dev \
    ## [OPTIONAL] ext/gmp
    libgmp-dev \
    ## [OPTIONAL] ext/intl
    libicu-dev \
    ## [OPTIONAL] ext/imap
    libc-client2007e-dev \
    ## [OPTIONAL] ext/pdo_mysql (via mariadb compatibility bindings)
    libmariadb-dev-compat \
    ## cleanup apt list and everything we normally do not need in a container
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# default test user
ARG USERNAME=php-tester
ARG USER_UID=1000
ARG USER_GID=1000
## add user group and user
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
    ## add sudo support f.e. for running make install in container
    && apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends sudo \
    && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME} \
    ## cleanup apt list and everything we normally do not need in a container
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

## switch to user
USER ${USERNAME}
