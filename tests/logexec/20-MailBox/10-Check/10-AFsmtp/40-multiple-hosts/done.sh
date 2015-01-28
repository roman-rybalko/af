#!/bin/sh -x

. "$TESTCONF"

del_ldif system.ldif

stop_server smtp1
stop_server smtp2
