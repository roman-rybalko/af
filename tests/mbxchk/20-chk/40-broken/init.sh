#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif
touch .tasks/r1-cli1-test.com-absent

start_server mx -s 1 -e server.env -p 25251 -r absent@test.com
rm -f server.env
