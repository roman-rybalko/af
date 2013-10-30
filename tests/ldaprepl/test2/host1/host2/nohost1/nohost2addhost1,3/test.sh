#!/bin/sh -ex
. "$TESTCONF"

"$TESTDIR"/work.sh
match_ldif "olcDatabase={2}mdb,cn=config" "olcSyncRepl:" match.ldif
