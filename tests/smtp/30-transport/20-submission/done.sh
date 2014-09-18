#!/bin/sh -x

. "$TESTCONF"

del_ldif system.ldif
add_ldif system-done.ldif
add_ldif user-done.ldif
