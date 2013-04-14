#!/bin/sh

set -ex

cd /

export PACKAGESITE=http://deploy/packages/All/

pkg_add -r ca_root_nss-3.14.3

fetch http://deploy/ssl.tgz
tar -zxv -f ssl.tgz -C /
rm -vf ssl.tgz

/usr/local/etc/periodic/daily/100.ca-root

pw groupadd ssl-key
# fetch http://deploy/ssl-`hostname`.tgz

rm -vf /`basename $0`
