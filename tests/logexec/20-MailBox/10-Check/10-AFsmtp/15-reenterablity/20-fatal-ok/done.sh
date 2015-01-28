#!/bin/sh -x

. "$TESTCONF"

del_ldif system.ldif

stop_server smtp
stop_server smtp2
rm -f smtp.env smtp2.env
