#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx1 -s 1 -p 12525
start_server mx2 -s 1 -p 22525
