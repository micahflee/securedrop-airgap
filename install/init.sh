#!/bin/bash

if [[ $EUID -ne 0 ]]; then
echo "You need to run this as root" 1>&2
    exit 1
fi

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

PERSISTENT=/home/amnesia/Persistent
INSTALL_DIR=$PERSISTENT/.securedrop-airgap

# securedrop-airgap is already installed
if /usr/bin/dpkg --get-selections | grep -q "^securedrop-airgap[[:space:]]*install$" >/dev/null; then
    /usr/bin/sudo -u amnesia /usr/bin/securedrop-airgap &

# securedrop-airgap isn't installed yet
else
    /sbin/iptables -I OUTPUT -o lo -p tcp --dport 6666 -j ACCEPT
    /usr/bin/sudo -u amnesia /usr/bin/notify-send "SecureDrop Air-Gap" "Setting up, please wait"
    /usr/bin/dpkg -i $INSTALL_DIR/securedrop-airgap_*.deb
    /usr/bin/sudo -u amnesia /usr/bin/notify-send "SecureDrop Air-Gap" "All set up now, launching"
    /usr/bin/sudo -u amnesia /usr/bin/securedrop-airgap &
fi
