#!/bin/sh -e

zone=$1
{
	host -t srv _kerberos._tcp.$zone | awk '{print $8}'
	host -t srv _kerberos._udp.$zone | awk '{print $8}'
} | sort -u
