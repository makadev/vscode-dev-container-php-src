#!/bin/bash

THIS_PATH=${BASH_SOURCE%/*}
source ${THIS_PATH}/config.sh

cd ${PHP_SOURCE}

sudo make install
sudo mkdir -p ${INI_DIR} ${INI_SCAN_DIR}
sudo cp php.ini-production ${INI_DIR}/php.ini
