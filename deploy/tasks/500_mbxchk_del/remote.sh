#!/bin/sh -ex
. ./remote.conf

pkg_delete `pkg_info -E 'p5-perl-ldap-*'` || true

rm -Rvf /usr/local/advancedfiltering/mbxchk

rmuser -yv mbxchk || true
./db-mod.sh -c || true
