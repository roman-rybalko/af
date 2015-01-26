#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif

rm -vf 1.ldif 2.ldif
