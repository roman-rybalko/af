#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif
add_ldif system-st.ldif

start_server spamtrap -s 1 -e server.env
start_server mx -p 2525
sleep 1 # wait server to start
rm -f server.env
