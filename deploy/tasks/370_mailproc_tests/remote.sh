#!/bin/sh -ex
. ./remote.conf
cat mailproc-tests.ldif | ldapmodify -a -x -D cn=admin,ou=system,o=advancedfiltering -w admin
