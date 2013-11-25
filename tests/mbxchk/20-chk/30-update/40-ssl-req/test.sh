#!/bin/sh -ex
. "$TESTCONF"

"$TESTDIR"/mbxchk.sh
[ ! -e .tasks/r1-cli1-test.com-absent ]
match_ldif "afUSMTPDMBLocalPart=absent,afUSMTPDomainName=test.com,afUClientName=cli1,\
afUServiceRealm=r1+afUServiceName=smtp,ou=user,o=advancedfiltering" \
"^afUSMTPDMBLocalPart|afUSMTPDMBIsAbsent" match.ldif
