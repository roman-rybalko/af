#!/bin/sh -ex

. "$TESTCONF"

stop_server error
stop_server mx
rm -f server.env
