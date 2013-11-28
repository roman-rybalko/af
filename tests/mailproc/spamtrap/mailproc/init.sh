#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

rm -Rf .base
mkdir .base
tar -xf ../.out/cf_latest.tgz -C .base
tar -xf ../.out/st_latest.tgz -C .base

./mailproc.sh -l -v 3 &
# -d all
pid=$!
echo $pid > mailproc.pid
