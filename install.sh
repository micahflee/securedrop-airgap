#!/bin/bash

if [[ $EUID -ne 0 ]]; then
echo "You need to run this as root" 1>&2
    exit 1
fi

PERSISTENT=/home/amnesia/Persistent
INSTALL_DIR=$PERSISTENT/.securedrop-airgap
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# todo: finish install script
