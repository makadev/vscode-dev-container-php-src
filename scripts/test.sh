#!/bin/bash

source /workspace/scripts/config.sh

cd ${PHP_SOURCE}

TEST_PHP_ARGS="-j${NRJOBS}"
export TEST_PHP_ARGS
/usr/bin/make test
