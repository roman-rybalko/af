#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif
"$TESTDIR"/init-data.pl # perl storable is not cross-platform-portable

start_server mx_notls -s 1 -e server.env -p 25251 -r absent@test.com
rm -f server.env
