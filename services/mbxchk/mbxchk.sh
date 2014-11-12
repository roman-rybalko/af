#!/bin/sh -ex

. `dirname $0`/mbxchk.conf
`dirname $0`/mbxchk.pl -h
exec `dirname $0`/mbxchk.pl -U $LDAP -D $LDAPDN -W $LDAPPW -t $TASKD -S $SSLD -T $TOUT "$@"
