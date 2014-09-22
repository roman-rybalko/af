#!/bin/sh -ex

. "$TESTCONF"

add_ldif system-init.ldif
add_ldif system.ldif
add_ldif user.ldif
