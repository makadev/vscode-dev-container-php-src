#!/bin/bash

source /workspace/scripts/config.sh

## ask for cleaning (no dryrun) of the source path
function cleanForReal {
    read -p "Run clean? This can not be undone! (y/n): " answer
    while true; do
        case ${answer} in
            y|Y)
                git clean -xdf
                echo "Done cleaning"
                return
            ;;
            n|N)
                echo "Skipped cleaning"
                return
            ;;
            * )
                read -p "Did not understand your answer, please type y for yes and n for no. (y/n): " answer
            ;;
        esac
    done
}

## ask for cleaning (dryrun first) of the source path
function cleanDryRun {
    read -p "Run clean (dry-run)? (y/n): " answer
    while true; do
        case ${answer} in
            y|Y)
                git clean -xdfn
                cleanForReal
                return
            ;;
            n|N)
                echo "Skipped cleaning"
                return
            ;;
            * )
                read -p "Did not understand your answer, please type y for yes and n for no. (y/n): " answer
            ;;
        esac
    done
}

if [[ -d ${PHP_SOURCE} ]]; then
    ## run clean and try to remove all files that don't belong into the source tree
    cd ${PHP_SOURCE}
    /usr/bin/make clean
    cleanDryRun
fi