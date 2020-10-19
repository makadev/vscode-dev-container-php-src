#!/bin/bash

THIS_PATH=${BASH_SOURCE%/*}
source ${THIS_PATH}/config.sh

cd ${PHP_SOURCE}

sudo make install
