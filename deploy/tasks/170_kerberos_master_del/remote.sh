#!/bin/sh -ex
. ./remote.conf

service kadmind stop || true
service kpasswdd stop || true

rm -vf /etc/rc.conf.d/kadmind /etc/rc.conf.d/kpasswdd /var/heimdal/kadmind.acl

service inetd stop || true
sed 's/^#krb5_prop/krb5_prop/' /etc/inetd.conf > /etc/inetd.conf.new
mv -f /etc/inetd.conf.new /etc/inetd.conf
service inetd start || true
