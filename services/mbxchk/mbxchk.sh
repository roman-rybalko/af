#!/bin/sh -ex

. `dirname $0`/mbxchk.conf
exec `dirname $0`/mbxchk.pl -U $LDAP -D $LDAPDN -W $LDAPPW -t $TASKD -v 2