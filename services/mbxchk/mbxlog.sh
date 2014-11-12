#!/bin/sh -ex

. `dirname $0`/mbxchk.conf
`dirname $0`/mbxlog.pl -h
exec `dirname $0`/mbxlog.pl -l $LOG -b $LOGBK -s $STATE -t $TASKD "$@"
