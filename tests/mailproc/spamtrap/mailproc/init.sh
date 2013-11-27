#!/bin/sh -ex

. "$TESTCONF"

rm -Rf .tmp
mkdir .tmp
tar -xf ../.out/cf_latest.tgz -C .tmp
tar -xf ../.out/st_latest.tgz -C .tmp
