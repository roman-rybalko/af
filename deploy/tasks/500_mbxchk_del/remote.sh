#!/bin/sh -ex
. ./remote.conf

pkg delete -y p5-perl-ldap || true
pkg autoremove -y

rm -Rvf /usr/local/advancedfiltering/mbxchk

rmuser -yv mbxchk || true
./db-mod.sh -c || true
