#!/bin/sh -ex
. ./remote.conf

service kerberos stop
grep -v kerberos5_server_enable /etc/rc.conf > /etc/rc.conf.new
mv -f /etc/rc.conf.new /etc/rc.conf

service inetd stop
grep -v /usr/libexec/hpropd /etc/inetd.conf > /etc/inetd.conf.new
mv -f /etc/inetd.conf.new /etc/inetd.conf
service inetd start || true

rm -vf /var/heimdal/*
