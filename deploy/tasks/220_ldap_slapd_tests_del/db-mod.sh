#!/bin/sh -ex
cat *.ldif | ldapmodify -a -x -D cn=admin,ou=auth -w admin
