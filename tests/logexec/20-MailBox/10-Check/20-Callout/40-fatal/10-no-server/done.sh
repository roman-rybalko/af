#!/bin/sh -x

. "$TESTCONF"

add_ldif user-done.ldif
del_ldif user.ldif