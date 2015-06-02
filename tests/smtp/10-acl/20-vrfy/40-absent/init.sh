#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif
add_ldif user.ldif

start_server mx -s 1 -p 12525 -r '[Rr][Cc][Pp][Tt]' -y "599 rejected"
