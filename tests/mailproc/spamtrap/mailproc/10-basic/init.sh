#!/bin/sh -ex

. "$TESTCONF"

rm -Rf .mime
mkdir .mime

cp -v ../../.init/*/*.mime .mime
mime_add_hdr.sh sender@tests.advancedfintering.net recipient@tests.advancedfiltering.net r1 .mime/*.mime
