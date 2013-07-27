#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif
add_ldif user-init.ldif
