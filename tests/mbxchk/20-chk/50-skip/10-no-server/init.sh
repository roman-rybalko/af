#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif
"$TESTDIR"/init-data.pl # perl storable is not cross-platform-portable
