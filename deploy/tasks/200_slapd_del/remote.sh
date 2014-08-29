#!/bin/sh -ex
. ./remote.conf

pkg delete -y openldap-server || true
pkg autoremove -y
rmuser -yv ldap || true
