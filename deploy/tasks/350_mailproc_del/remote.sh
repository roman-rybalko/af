#!/bin/sh -ex
. ./remote.conf

pkg delete -y p5-perl-ldap || true
pkg autoremove -y

rm -Rvf /usr/local/advancedfiltering/mailproc /usr/local/advancedfiltering/http/mailproc

rmuser -yv mailproc || true
rmuser -yv spamd || true

./db-mod.sh -c || true
