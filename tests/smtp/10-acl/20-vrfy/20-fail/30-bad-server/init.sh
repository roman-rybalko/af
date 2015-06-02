#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx -s 1 -p 12525 -r '[Rr][Cc][Pp][Tt]' -y "499 temporary reject"
