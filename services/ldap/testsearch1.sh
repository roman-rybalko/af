#!/bin/sh

set -ex

ldapsearch -h test1.hosts.advancedfiltering.net \
 -ZZ \
 -x -D cn=admin,ou=system,o=advancedfiltering -w admin \
 -LLL \
 -b ou=system,o=advancedfiltering