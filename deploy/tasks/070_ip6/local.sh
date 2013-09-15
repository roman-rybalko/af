#!/bin/sh -ex

host=$1
[ -n "$host" ]

. ./local.conf

[ -e $servers/$host.ip6 ]
[ -e $servers/$host.ip6.gw ]
[ -e $servers/$host.ip6.pfx ]

> rc.conf
echo "ifconfig_${iface}_ipv6=\"inet6 `cat $servers/$host.ip6` prefixlen `cat $servers/$host.ip6.pfx`\"" >> rc.conf
echo "ipv6_defaultrouter=\"`cat $servers/$host.ip6.gw`\"" >> rc.conf
