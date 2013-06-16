#!/bin/sh -ex

which swaks
which ldapmodify
which ldapdelete
#./smtp_server.pl -t

. $TESTCONF

cat system.ldif user.ldif \
	| ./ldif_nl.pl \
	| sed "s/src.hosts.advancedfiltering.net/$SRC_HOST/g;s/dst.hosts.advancedfiltering.net/$DST_HOST/g;" \
	| ./ldapadd.sh
