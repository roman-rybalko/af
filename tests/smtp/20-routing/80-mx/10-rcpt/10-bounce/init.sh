#!/bin/sh -ex

. "$TESTCONF"

start_server bounce -s 1 -e bounce.env -p 15025
rm -f bounce.env
#start_server mx_rcpt -s 1 -e mx_rcpt.env -p 12325
#rm -f mx_rcpt.env
start_server mx_domain -s 1 -e mx_domain.env -p 22325
rm -f mx_domain.env
start_server mx_client -s 1 -e mx_client.env -p 32325
rm -f mx_client.env
