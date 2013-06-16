#!/bin/sh -ex

. ./test.conf

cat system.ldif user.ldif \
	| ./ldif_nl.pl \
	| sed "s/src.hosts.advancedfiltering.net/$SRC_HOST/g;s/dst.hosts.advancedfiltering.net/$DST_HOST/g;" \
	| ./ldif_dn.pl \
	| ./ldapdel.sh
