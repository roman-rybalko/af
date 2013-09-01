#!/bin/sh -ex

. `dirname $0`/mailproc.conf
export HOME
sleep 86400
exec `dirname $0`/work.pl #-1 -2 -3
