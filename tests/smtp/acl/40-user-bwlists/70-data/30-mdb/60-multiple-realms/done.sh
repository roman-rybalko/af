#!/bin/sh -x

. "$TESTCONF"

del_ldif user2.ldif
del_ldif user3.ldif
del_ldif system2.ldif
del_ldif system3.ldif
add_ldif system-done.ldif
