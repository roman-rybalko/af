#!/bin/sh -ex

echo $1 | grep '\.hosts\.advancedfiltering\.net\.'
host $1
./dnsupd.sh add _kerberos._tcp.kerberos.advancedfiltering.net. 60 IN SRV 20 1 88 $1
./dnsupd.sh add _kerberos._udp.kerberos.advancedfiltering.net. 60 IN SRV 20 1 88 $1
