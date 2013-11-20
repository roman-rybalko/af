#!/bin/sh -ex

. `dirname $0`/smtp.conf
exec `dirname $0`/work.pl -U $LDAP -D $LDAPDN -W $LDAPPW -l $SMTPLOG -b $SMTPLOGBK -s $STATE -v 2
