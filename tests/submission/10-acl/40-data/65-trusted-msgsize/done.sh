#!/bin/sh -x

. "$TESTCONF"

del_ldif user2.ldif
del_ldif user.ldif
add_ldif system-tms-done.ldif
