#!/bin/sh -ex
. ./remote.conf

./mkca.sh
mv -vf ca /usr/local/advancedfiltering/ssl/
chown -R root:advancedfiltering_ssl /usr/local/advancedfiltering/ssl/ca
