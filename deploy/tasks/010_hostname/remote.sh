#!/bin/sh -ex
. remote.conf

sed -I .orig "s/template.$domain/$host.$domain/; s/inet 10.255.255.118 /inet $ip /;" /etc/rc.conf
rm /etc/rc.conf.orig
