#!/bin/sh -ex
. ./remote.conf

cat configure > /usr/local/etc/exim/configure
mkdir /usr/local/etc/exim/ssl
chown exim /usr/local/etc/exim/ssl
chmod og-rwx /usr/local/etc/exim/ssl

cp dkim-smtp.key /usr/local/etc/exim/
chown exim /usr/local/etc/exim/dkim-smtp.key
chmod og-rwx /usr/local/etc/exim/dkim-smtp.key

service exim stop || true
service exim start
