#!/bin/bash

## these should not be changed
USERNAME=php-tester
WORKSPACE=${BASH_SOURCE%/*}/..
PHP_SOURCE=${WORKSPACE}/php-src
PHP_REPOSITORY=https://github.com/php/php-src.git
CONFIG_OVERRIDES_FILE=${WORKSPACE}/scripts/config-overrides.sh

## typical overrideables
PHP_FORKED_REPOSITORY=
INSTALL_PREFIX=/usr/local
INI_DIR=${INSTALL_PREFIX}/etc/php
INI_SCAN_DIR=${INI_DIR}/conf.d
CONFIGURE_PARAMS="--prefix=${INSTALL_PREFIX}
    --with-config-file-path=${INI_DIR}
    --with-config-file-scan-dir=${INI_SCAN_DIR}"

##nr procs + 1 jobs (cores, HT might be ignored)
EXPECTED_NR_PROCS=$(grep -c '^processor' /proc/cpuinfo)
NRJOBS=$(( $EXPECTED_NR_PROCS + 1 ))

## load custom configs
if [[ -f ${CONFIG_OVERRIDES_FILE} ]]; then
    source ${CONFIG_OVERRIDES_FILE}
fi
