#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

rm -Rf .base .mime
mkdir .base .mime
tar -xf ../.out/cf_latest.tgz -C .base
tar -xf ../.out/st_latest.tgz -C .base

./mailproc.sh -l -v 3 &
# -d all
pid1=$!
echo $pid1 > mailproc1.pid

./mailproc.sh -l -v 3 &
# -d all
pid2=$!
echo $pid2 > mailproc2.pid
