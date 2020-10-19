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
CONFIGURE_PARAMS="--prefix=${INSTALL_PREFIX}"

##nr procs + 1 jobs (cores, HT might be ignored)
EXPECTED_NR_PROCS=$(grep -c '^processor' /proc/cpuinfo)
NRJOBS=$(( $EXPECTED_NR_PROCS + 1 ))

## load custom configs
if [[ -f ${CONFIG_OVERRIDES_FILE} ]]; then
    source ${CONFIG_OVERRIDES_FILE}
fi
