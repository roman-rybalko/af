#!/bin/sh -ex
. "$TESTCONF"

"$TESTDIR"/ldaprepl.sh
match_ldif "olcDatabase={2}mdb,cn=config" "olcSyncRepl:" match.ldif
