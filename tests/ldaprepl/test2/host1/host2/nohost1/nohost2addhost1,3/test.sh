#!/bin/sh -ex
. "$TESTCONF"

"$TESTDIR"/ldaprepl.sh -v 3
match_ldif "olcDatabase={2}mdb,cn=config" "olcSyncRepl:" match.ldif
