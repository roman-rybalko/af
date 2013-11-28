#!/bin/sh -ex

. "$TESTCONF"

rm -Rf .mime
mkdir .mime

cp -v ../../.init/*/*.mime .mime
