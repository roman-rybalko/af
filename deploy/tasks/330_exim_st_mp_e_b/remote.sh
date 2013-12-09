#!/bin/sh -ex
. ./remote.conf

cat configure > /usr/local/etc/exim/configure
for d in spamtrap hamtrap mailproc error bounce doublebounce; do
	mkdir /usr/local/etc/exim/$d
	chown exim:exim /usr/local/etc/exim/$d
	chmod 0750 /usr/local/etc/exim/$d
done

service exim stop || true
service exim start
