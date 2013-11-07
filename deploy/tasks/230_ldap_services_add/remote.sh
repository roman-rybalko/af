#!/bin/sh -ex
. ./remote.conf
cat services.ldif olcAccess.ldif olcLimits.ldif | ldapmodify -a -x -D cn=admin,ou=auth -w admin
