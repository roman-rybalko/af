#!/bin/sh -ex
. ./remote.conf
ldapmodify -x -D cn=admin,ou=system,o=advancedfiltering -w admin -f olcAccess.ldif
