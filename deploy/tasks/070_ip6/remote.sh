#!/bin/sh -ex
. ./remote.conf
[ -z "`grep ipv6_defaultrouter /etc/rc.conf`" ]
cat rc.conf >> /etc/rc.conf
