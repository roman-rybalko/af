#!/bin/sh -ex
. ./remote.conf

cp -v submission.services.advancedfiltering.net.* /usr/local/advancedfiltering/ssl/
chown -v root:af_ssl /usr/local/advancedfiltering/ssl/submission.services.advancedfiltering.net.*
chmod -v ug=r,o= /usr/local/advancedfiltering/ssl/submission.services.advancedfiltering.net.*
