#!/bin/sh -x

. "$TESTCONF"

rm -Rvf .tmp .mime

del_ldif user-clean.ldif
del_ldif user.ldif
