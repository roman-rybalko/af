#!/bin/sh -ex
. ./remote.conf

./mkca.sh
mv -vf ca /usr/local/advancedfiltering/ssl/
chown -R root:af_ssl /usr/local/advancedfiltering/ssl/ca
