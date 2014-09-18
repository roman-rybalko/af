#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif
add_ldif system-init.ldif
