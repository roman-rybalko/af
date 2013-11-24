#!/bin/sh -ex

. "$TESTDIR"/mbxchk.conf
RC="$TESTDIR"/.tools/ldaprc
>"$RC"
[ -n "$LDAP" ]; echo "URI $LDAP" >> "$RC"
[ -z "$LDAPCERT" ] || echo "TLS_CERT $LDAPCERT" >> "$RC"
[ -z "$LDAPKEY" ] || echo "TLS_KEY $LDAPKEY" >> "$RC"
[ -z "$LDAPCADIR" ] || echo "TLS_CACERTDIR $LDAPCADIR" >> "$RC"
[ -z "$LDAPCADIR" ] || echo "TLS_REQCERT demand" >> "$RC"
[ -z "$LDAPCADIR" ] || echo "TLS_CRLCHECK all" >> "$RC"
