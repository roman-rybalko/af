#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif

start_server smtp1 -s 1 -p 2525
start_server smtp2 -s 1 -p 2526
