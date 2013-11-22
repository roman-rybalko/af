#!/bin/sh -ex

. `dirname $0`/mbxchk.conf
exec `dirname $0`/mbxlog.pl -l $SMTPLOG -b $SMTPLOGBK -s $STATE -t $TASKD -v 2
