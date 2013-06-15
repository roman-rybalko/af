#!/bin/sh -ex
. remote.conf

pw groupadd ssl-key || true
mkdir -p /usr/local/etc/ssl
cp -Rf *.crt *.key /usr/local/etc/ssl/
chown root:wheel /usr/local/etc/ssl/*.crt /usr/local/etc/ssl/*.key
chmod a+r /usr/local/etc/ssl/*.crt /usr/local/etc/ssl/*.key
chgrp ssl-key /usr/local/etc/ssl/*.key
chmod o-rwx,g-w /usr/local/etc/ssl/*.key
