#!/bin/sh -x

. "$TESTCONF"

wait_file mx2.env
stop_server mx2
rm -f mx2.env

del_ldif user2.ldif
del_ldif user3.ldif
del_ldif system2.ldif
del_ldif system3.ldif
add_ldif system-done.ldif
