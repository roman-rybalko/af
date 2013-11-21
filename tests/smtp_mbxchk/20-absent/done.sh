#!/bin/sh -x

. "$TESTCONF"

del_ldif user-clean.ldif
del_ldif user.ldif
rm -v mbxchk_state
