#!/bin/bash

THIS_PATH=${BASH_SOURCE%/*}
source ${THIS_PATH}/config.sh

if [[ ! -d "${PHP_SOURCE}" ]]; then
    ## clone if sources not installed
     ${THIS_PATH}/fetch-source.sh
fi

## change working dir to src path
cd ${PHP_SOURCE}

## create default configuration
./buildconf \
&& ./configure CC="$(which clang)" CXX="$(which clang++)" ${CONFIGURE_PARAMS} \
&& make "-j${NRJOBS}"

