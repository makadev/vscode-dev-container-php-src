#!/bin/bash

THIS_PATH=${BASH_SOURCE%/*}
source ${THIS_PATH}/config.sh

cd ${PHP_SOURCE}

TEST_PHP_ARGS="-j${NRJOBS}"
export TEST_PHP_ARGS
make test
