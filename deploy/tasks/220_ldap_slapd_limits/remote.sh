#!/bin/sh -ex
. ./remote.conf
ldapmodify -x -D cn=admin,ou=auth -w admin -f olcLimits.ldif
