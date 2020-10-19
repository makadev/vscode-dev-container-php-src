#!/bin/bash

THIS_PATH=${BASH_SOURCE%/*}
source ${THIS_PATH}/config.sh

AUTOCRLF_STATE=$(git config --global core.autocrlf)

if [[ "${AUTOCRLF_STATE}" != "false" ]]; then
    ## vscode copies .gitconfig but on windows this most likely has autocrlf=true
    ## wich will make break f.e. scripts when being checked out with CRLF
    ## we know we are on linux so turn it off
    git config --global core.autocrlf false
fi

if [[ ! -d "${PHP_SOURCE}" ]]; then
    if [[ -z "${PHP_FORKED_REPOSITORY}" ]]; then
        ## no fork repository given, clone upstream as origin
        echo "Cloning PHP Source from ${PHP_REPOSITORY}"
        git clone ${PHP_REPOSITORY} ${PHP_SOURCE}
    else
        ## fork repository given, clone as origin
        echo "Cloning PHP Source from ${PHP_FORKED_REPOSITORY}"
        git clone ${PHP_FORKED_REPOSITORY} ${PHP_SOURCE}
        ## set php-src as upstream
        cd ${PHP_SOURCE}
        git remote add upstream ${PHP_REPOSITORY}
        ## update master from upstream
        git fetch upstream
    fi
else
    echo "fetching PHP Source from ${PHP_REPOSITORY}"
    cd ${PHP_SOURCE}
    git fetch
    if [[ ! -z "${PHP_FORKED_REPOSITORY}" ]]; then
        ## update master from upstream and rebase
        git fetch upstream
    fi
fi
