#!/bin/sh -ex
. ./remote.conf

pkg delete -y p5-perl-ldap || true
pkg autoremove -y

rm -Rvf /usr/local/advancedfiltering/ldaprepl

rmuser -yv ldaprepl || true
./db-mod.sh -c || true
