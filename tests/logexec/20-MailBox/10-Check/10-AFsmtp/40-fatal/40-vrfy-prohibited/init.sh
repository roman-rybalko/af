#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif

start_server smtp -s 1 -p 2525 -r '[Vv][Rr][Ff][Yy]' -y "252 prohibited"
