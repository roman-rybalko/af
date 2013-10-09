#!/bin/sh -ex

. `dirname $0`/mailproc.conf
exec `dirname $0`/work.pl -U $LDAP -D $LDAPDN -W $LDAPPW
