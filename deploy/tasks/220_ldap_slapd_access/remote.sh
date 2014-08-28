#!/bin/sh -ex
. ./remote.conf
ldapmodify -x -D cn=admin,ou=auth -w admin -f olcAccess.ldif
