#!/bin/sh -ex
. ./remote.conf

pkg install -y compat6x-amd64

cd /tmp
fetch -o - http://deploy/deploy/vmware-freebsd-tools.tar.gz | tar -xvf -
cd vmware-tools-distrib
./vmware-install.pl default

rm -f /etc/vmware-tools/not_configured
fetch -o - http://deploy/deploy/vmware-freebsd-tools-fix.tgz | tar -xvf - -C /

cd /tmp
rm -Rf vmware-*
