#!/bin/sh -ex
. "$TESTCONF"

"$TESTDIR"/work.sh
[ -e mbxchk_state ]
match_ldif "afUSMTPDMBLocalPart=absent,afUSMTPDomainName=test.com,afUClientName=cli1,\
afUServiceRealm=r1+afUServiceName=smtp,ou=user,o=advancedfiltering" \
"^afUSMTPDMBLocalPart|afUSMTPDMBIsAbsent" match.ldif
