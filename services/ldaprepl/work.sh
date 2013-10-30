#!/bin/sh -ex

. `dirname $0`/ldaprepl.conf
exec `dirname $0`/work.pl -U $LDAP -D $LDAPDN -W $LDAPPW -n `hostname` -s "$SYNCREPL" -v 2
