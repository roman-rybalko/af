#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif
add_ldif system-st-off.ldif
