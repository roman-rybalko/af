#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif
add_ldif user-init.ldif
