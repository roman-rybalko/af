#!/bin/sh -ex
. ./remote.conf

rm -Rvf /usr/local/advancedfiltering/ldaprepl

rmuser -yv ldaprepl || true
./db-mod.sh
