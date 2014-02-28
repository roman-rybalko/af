#!/bin/sh -ex
. ./remote.conf

tar -xf heimdal.tgz -C /var/heimdal
./sshpass.sh deploy-init.pw ktutil get -p deploy/init hprop/`hostname`

echo "kerberos5_server_enable=\"YES\"" >> /etc/rc.conf
echo "inetd_enable=\"YES\" # kerberos5_server_enable" >> /etc/rc.conf
service kerberos start

echo "krb5_prop stream tcp nowait root /usr/libexec/hpropd hpropd" >> /etc/inetd.conf
service inetd restart
