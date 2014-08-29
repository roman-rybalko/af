#!/bin/sh -ex
cat crcfix.ldif schema-advancedfiltering.ldif db-init.ldif db-init2.ldif olcAccess.ldif olcLimits.ldif | ldapmodify -a -x -D cn=deploy,cn=config -w deploy
cat olcRootDel.ldif | ldapmodify -x -D cn=admin,ou=auth -w admin
