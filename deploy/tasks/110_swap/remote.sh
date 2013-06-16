#!/bin/sh -ex
. ./remote.conf

dd if=/dev/zero of=/swap bs=1M count=1024
chmod og-rwx /swap
echo 'swapfile="/swap"' >> /etc/rc.conf
