#!/bin/sh -ex
. ./remote.conf

pkg_delete -r `pkg_info -E 'p5-perl-ldap-*'` || true

rm -Rvf /usr/local/advancedfiltering/mailproc /usr/local/advancedfiltering/http/mailproc

rmuser -yv mailproc || true
rmuser -yv spamd || true

./db-mod.sh -c || true
