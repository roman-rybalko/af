#!/bin/sh -ex

. "$TESTCONF"

start_server service -s 13 -e service.env
rm -f service.env
