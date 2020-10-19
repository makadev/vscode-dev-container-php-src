#!/bin/bash

THIS_PATH=${BASH_SOURCE%/*}
source ${THIS_PATH}/config.sh

if [[ ! -d "${PHP_SOURCE}" ]]; then
    ## clone if sources not installed
    ${WORKSPACE}/scripts/fetch-source.sh
fi

## change working dir to src path
cd ${PHP_SOURCE}

## create default configuration and enable gcov
./buildconf \
&& ./configure ${CONFIGURE_PARAMS} \
    --enable-gcov \
make "-j${NRJOBS}"

## run tests (generates coverage information)
TEST_PHP_ARGS="-j${NRJOBS}"
export TEST_PHP_ARGS
make test \
&& make lcov-clean \
&& make lcov
