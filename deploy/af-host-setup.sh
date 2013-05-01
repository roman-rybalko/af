#!/bin/sh

set -ex

cd /

dd if=/dev/zero of=/swap bs=1M count=1024
echo 'swapfile="/swap"' >> /etc/rc.conf

echo 'setenv PACKAGESITE http://deploy/packages/All/' >> /root/.cshrc
echo 'export PACKAGESITE=http://deploy/packages/All/' >> /root/.profile

rm -vf /.cshrc /.profile /`basename $0`
