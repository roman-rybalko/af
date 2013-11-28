#!/bin/sh -ex

. `dirname $0`/ldaprepl.conf
exec `dirname $0`/ldaprepl.pl -U $LDAP -D $LDAPDN -W $LDAPPW -n `hostname` -s "$SYNCREPL" "$@"
