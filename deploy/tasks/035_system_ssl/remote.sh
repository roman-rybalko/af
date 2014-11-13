#!/bin/sh -ex
. ./remote.conf

pw groupadd af_ssl || true
mkdir /etc/advancedfiltering_ssl || true
chmod u=rwx,g=rx,o= /etc/advancedfiltering_ssl
./mkca.sh
mv -vf `hostname`.crt `hostname`.key ca /etc/advancedfiltering_ssl/
chown -R root:af_ssl /etc/advancedfiltering_ssl
chgrp af_ssl /etc/advancedfiltering_ssl/*.key
chmod g=r,o= /etc/advancedfiltering_ssl/*.key
