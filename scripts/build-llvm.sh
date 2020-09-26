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
&& ./configure CC="$(which clang)" CXX="$(which clang++)" ${CONFIGURE_PARAMS} \
&& /usr/bin/make "-j${NRJOBS}"
