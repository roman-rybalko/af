#!/bin/sh -ex
. ./remote.conf

rm -Rvf /usr/local/advancedfiltering/smtp/ssl/tests-smtp*
pkg delete -y p5-IO-Socket-SSL || true
pkg autoremove -y
