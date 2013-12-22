#!/bin/sh -x

. "$TESTCONF"

stop_server service
rm -f service.env
