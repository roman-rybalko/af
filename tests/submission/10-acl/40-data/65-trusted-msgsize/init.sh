#!/bin/sh -ex

. "$TESTCONF"

add_ldif system-tms-init.ldif
add_ldif user.ldif
