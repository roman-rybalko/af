#!/bin/sh -e

passfile=$1
[ -n "$passfile" ]
[ -f $passfile ]
pass="`cat $passfile`"
shift
exec expect -c "log_user 0 ; spawn $* ; expect assword: ; send \"$pass\\n\" ; interact; catch wait result; exit [lindex \$result 3]"
