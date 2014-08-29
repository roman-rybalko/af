#!/bin/sh -ex
. ./remote.conf

cp -Rfv tests-smtp* /usr/local/etc/exim/ssl/
chown -R exim /usr/local/etc/exim/ssl/tests-smtp*
chmod -R og-rwx /usr/local/etc/exim/ssl/tests-smtp*
