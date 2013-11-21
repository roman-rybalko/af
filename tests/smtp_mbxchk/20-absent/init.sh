#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif
rm -vf mbxchk_state
