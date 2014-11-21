#!/bin/sh -ex
. ./remote.conf

cp -v smtp.services.advancedfiltering.net.* /usr/local/advancedfiltering/ssl/
chown -v root:af_ssl /usr/local/advancedfiltering/ssl/smtp.services.advancedfiltering.net.*
chmod -v ug=r,o= /usr/local/advancedfiltering/ssl/smtp.services.advancedfiltering.net.*
