#!/bin/sh -ex
. ./remote.conf
cat tests.ldif olcAccess.ldif | ldapmodify -a -x -D cn=admin,ou=system,o=advancedfiltering -w admin
