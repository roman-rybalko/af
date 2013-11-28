#!/bin/sh -x

. "$TESTCONF"

del_ldif system.ldif

# cleanup
add_ldif system.ldif
"$TESTDIR"/ldaprepl.sh -v 3
del_ldif system.ldif
