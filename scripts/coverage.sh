#!/bin/bash

source /workspace/scripts/config.sh

if [[ ! -d "${PHP_SOURCE}" ]]; then
    ## clone if sources not installed
    /workspace/scripts/fetch-source.sh
fi

## change working dir to src path
cd ${PHP_SOURCE}

## create default configuration and enable gcov
./buildconf \
&& ./configure ${CONFIGURE_PARAMS} \
    --enable-gcov \
/usr/bin/make "-j${NRJOBS}"

## run tests (generates coverage information)
TEST_PHP_ARGS="-j${NRJOBS}"
export TEST_PHP_ARGS
/usr/bin/make test \
&& /usr/bin/make lcov-clean \
&& /usr/bin/make lcov
