#!/bin/sh -ex
. ./remote.conf

[ -z "`grep net.inet6.ip6.auto_linklocal /boot/loader.conf`" ]
[ -z "`grep ipv6_static_routes /etc/rc.conf`" ]

echo net.inet6.ip6.auto_linklocal=0 >> /boot/loader.conf

iface=`ifconfig | awk 'BEGIN{FS=":"} /flags/ && $1 != "lo0" {print $1;exit 0;}'`
echo "ipv6_static_routes=linklocal" >> /etc/rc.conf
echo "ipv6_route_linklocal=\"fe80::%$iface/64 -iface $iface\"" >> /etc/rc.conf
