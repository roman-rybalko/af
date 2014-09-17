#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif
add_ldif user-done.ldif
