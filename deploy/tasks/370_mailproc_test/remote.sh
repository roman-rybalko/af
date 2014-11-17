#!/bin/sh -ex
. ./remote.conf
cat mailproc-test.ldif | ldapmodify -a -x -D cn=admin,ou=auth -w admin
