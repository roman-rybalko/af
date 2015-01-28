#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif

start_server smtp -s 1 -p 2525 -r absent
