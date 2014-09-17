#!/bin/sh -x

. "$TESTCONF"

stop_server bounce
rm -f bounce.env
stop_server mx_rcpt
rm -f mx_rcpt.env
stop_server mx_domain
rm -f mx_domain.env
stop_server mx_client
rm -f mx_client.env
