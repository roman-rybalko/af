#!/bin/sh -ex
. ./remote.conf

service inetd stop || true
sed 's/^krb5_prop/#krb5_prop/' /etc/inetd.conf > /etc/inetd.conf.new
mv -f /etc/inetd.conf.new /etc/inetd.conf
service inetd start || true

tar -xvf heimdal_master.tgz -C /
chown -v root:wheel /etc/rc.conf.d/kadmind /etc/rc.conf.d/kpasswdd /var/heimdal/kadmind.acl

service kadmind start
service kpasswdd start
sleep 1
