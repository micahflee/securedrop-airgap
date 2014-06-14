#!/bin/bash

# note: for now this needs to be run on an internet-connected Tails computer

if [[ $EUID -ne 0 ]]; then
echo "You need to run this as root" 1>&2
    exit 1
fi

PERSISTENT=/home/amnesia/Persistent
INSTALL_DIR=$PERSISTENT/.securedrop-airgap
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

VERSION=`cat version`

# install dependencies
#apt-get update
#apt-get install -y build-essential fakeroot python-all python-stdeb

# build a debian package
rm -r deb_dist &>/dev/null 2>&1
sudo -u amnesia python setup.py --command-packages=stdeb.command bdist_deb

# setup install dir
rm -rf $INSTALL_DIR &>/dev/null 2>&1
mkdir -p $INSTALL_DIR
cp $ROOT/deb_dist/securedrop-airgap_$VERSION-1_all.deb $INSTALL_DIR
cp $ROOT/install/securedrop.png $INSTALL_DIR
cp $ROOT/install/init.sh $INSTALL_DIR

# compile the setuid hack script
gcc -o $INSTALL_DIR/init $ROOT/install/init.c

# set permissions
chown -R root:root $INSTALL_DIR
chmod 755 $INSTALL_DIR
chmod 644 $INSTALL_DIR/*
chmod 755 $INSTALL_DIR/init.sh
chmod 755 $INSTALL_DIR/init
chmod +s $INSTALL_DIR/init

# add launcher
cp $ROOT/install/securedrop-airgap-init.desktop /home/amnesia/Persistent
chown amnesia:amnesia /home/amnesia/Persistent/securedrop-airgap-init.desktop
chmod 755 /home/amnesia/Persistent/securedrop-airgap-init.desktop
