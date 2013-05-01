#!/bin/sh

set -ex

cd /

export PACKAGESITE=http://deploy/packages/All/
pkg_add -r compat6x-amd64-6.4.604000.200810_3

cd /tmp
fetch http://deploy/vmware-freebsd-tools.tar.gz
fetch http://deploy/vmware-freebsd-tools-fix.tgz
tar -zxf vmware-freebsd-tools.tar.gz
cd vmware-tools-distrib
./vmware-install.pl default

cd /tmp
rm -f /etc/vmware-tools/not_configured
tar -zxvf vmware-freebsd-tools-fix.tgz -C /

cd /tmp
rm -Rf vmware-*

rm -vf /`basename $0`
