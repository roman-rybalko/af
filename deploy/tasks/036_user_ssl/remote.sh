#!/bin/sh -ex
. ./remote.conf

pw groupadd advancedfiltering_ssl || true
mkdir -p /usr/local/advancedfiltering/ssl
chown root:advancedfiltering_ssl /usr/local/advancedfiltering/ssl
chmod u=rwx,g=rx,o= /usr/local/advancedfiltering/ssl
