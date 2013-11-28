#!/bin/sh -ex

. `dirname $0`/mailproc.conf
exec `dirname $0`/mailproc.pl -c $SACF -s $SACFSITE -u $SAST -U $LDAP -D $LDAPDN -W $LDAPPW -m $MIME -x $CNT "$@"
