#!/bin/bash

THIS_PATH=${BASH_SOURCE%/*}
source ${THIS_PATH}/config.sh

if [[ -d "${PHP_SOURCE}" ]]; then
    if [[ ! -z "${PHP_FORKED_REPOSITORY}" ]]; then
        ## update master from upstream and rebase
        cd ${PHP_SOURCE}
        git fetch upstream \
        && git checkout master \
        && git rebase upstream/master
    fi
fi
