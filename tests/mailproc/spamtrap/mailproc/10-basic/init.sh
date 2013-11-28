#!/bin/sh -ex

. "$TESTCONF"



add_ldif user.ldif

rm -Rf .tmp .mime
mkdir .tmp .mime
tar -xf ../.out/cf_latest.tgz -C .tmp
tar -xf ../.out/st_latest.tgz -C .tmp

./mailproc.sh -l -v 3 &
# -d all
pid=$!
echo $pid > mailproc.pid

cp -v ../.init/*/*.mime .mime
mime_add_hdr.sh sender@tests.advancedfintering.net recipient@tests.advancedfiltering.net r1 .mime/*.mime
