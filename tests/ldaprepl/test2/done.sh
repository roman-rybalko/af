#!/bin/sh -x

. "$TESTCONF"

del_ldif system.ldif

# cleanup
add_ldif system.ldif
"$TESTDIR"/work.sh
del_ldif system.ldif
