#!/bin/sh -ex
. remote.conf

pw groupadd ssl-key || true
cp -Rf `hostname`.crt `hostname`.key ca /etc/ssl/
chown -R root:wheel /etc/ssl
chmod -R a+r /etc/ssl
chgrp ssl-key /etc/ssl/*.key
chmod o-rwx,g-w /etc/ssl/*.key
