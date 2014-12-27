#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

# tool many sessions - hard to count - using sleep
start_server mx1 -p 12525
