#!/bin/sh -ex
. ./remote.conf

mkdir -p /usr/local/advancedfiltering/ssl
ln -s ../advancedfiltering/ssl /usr/local/etc/ssl
cp -Rf ca /usr/local/etc/ssl/
chown -R root:wheel /usr/local/etc/ssl/ca
chmod -R a+r /usr/local/etc/ssl/ca
