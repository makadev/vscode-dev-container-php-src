#!/bin/bash

THIS_PATH=${BASH_SOURCE%/*}
source ${THIS_PATH}/config.sh

## Expected:
## $1 key
## $2 value to set, empty for disabling (-> default value)

PHP_INI=${PHP_INI:-"${INI_DIR}/php.ini"}

function usage {
    echo "Usage: update-php-ini <key> [<new value>]"
    echo "  $1"
    echo "Command will update the php.ini with for given key and fail if either key was not found, not active or old value didn't match."
    echo "  F.e.: "
    echo " update-php-ini opcache.enable     -> comment out opcache.enable"
    echo " update-php-ini opcache.enable 1   -> uncomment opcache.enable and set it's value to 1"
    exit 1
}

if [[ -z "$1" ]]; then
    usage "missing key to search for"
fi

if [[ ! -f "${PHP_INI}" ]]; then
    usage "${PHP_INI} missing"
fi

TARGET_FILE=`mktemp`

# disable setting, just remove every line that contains the setting
grep -Ev "^\s*;?\s*$1+\s*=.*$" ${PHP_INI} > ${TARGET_FILE}

if [[ ! -z "$2" ]]; then
    # enable setting, remove every line that contains the setting before and add the enabled setting at the end
    echo "$1 = $2" >> ${TARGET_FILE}
fi

mv ${TARGET_FILE} ${PHP_INI}
chmod 644 ${PHP_INI}
