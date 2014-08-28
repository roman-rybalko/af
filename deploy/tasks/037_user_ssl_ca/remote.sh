#!/bin/sh -ex
. ./remote.conf

cp -Rf ca /usr/local/advancedfiltering/ssl/
chown -R root:advancedfiltering_ssl /usr/local/advancedfiltering/ssl/ca
