#!/bin/sh -ex

. "$TESTCONF"

add_ldif user-init.ldif
add_ldif user.ldif
