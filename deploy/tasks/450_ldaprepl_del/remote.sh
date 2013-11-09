#!/bin/sh -ex
. ./remote.conf

pkg_delete `pkg_info -E 'p5-perl-ldap-*'` || true

rm -Rvf /usr/local/advancedfiltering/ldaprepl

rmuser -yv ldaprepl || true
./db-mod.sh -c || true
