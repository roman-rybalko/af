#!/bin/sh -ex

. `dirname $0`/mbxchk.conf
exec `dirname $0`/mbxlog.pl -l $LOG -b $LOGBK -s $STATE -t $TASKD -v 2
