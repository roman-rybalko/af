#!/bin/sh -ex
. ./remote.conf

cp -Rf *.crt *.key /usr/local/advancedfiltering/ssl/
chown root:af_ssl /usr/local/advancedfiltering/ssl/*.crt /usr/local/advancedfiltering/ssl/*.key
