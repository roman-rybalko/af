#!/bin/sh -ex
. ./remote.conf
cat mailproc-tests.ldif | ldapmodify -a -x -D cn=admin,ou=auth -w admin
