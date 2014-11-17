#!/bin/sh -ex
. ./remote.conf

[ ! -e /usr/sbin/pw.orig ]
mv -v /usr/sbin/pw /usr/sbin/pw.orig
cp -v pw /usr/sbin/
chown -v root:wheel /usr/sbin/pw
chmod -v 0555 /usr/sbin/pw
