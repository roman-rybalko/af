#!/bin/sh -ex

. `dirname $0`/mailproc.conf

SRCDIR=`dirname $0`
STHOST=`$SRCDIR/ldap.pl -U $LDAP -D "$LDAPDN" -W "$LDAPPW" -q hostname -s spamtrap -1`
mkdir -v $SAUPD || true
cd $SAUPD
curl --location --fail --remote-time -z cf_latest.tgz --cert /etc/ssl/`hostname`.crt --key /etc/ssl/`hostname`.key --capath /etc/ssl/ca https://$STHOST/spamtrap/cf_latest.tgz -o cf_latest.tgz
curl --location --fail --remote-time -z st_latest.tgz --cert /etc/ssl/`hostname`.crt --key /etc/ssl/`hostname`.key --capath /etc/ssl/ca https://$STHOST/spamtrap/st_latest.tgz -o st_latest.tgz
[ ! -e $BASE/cf_latest.tgz -o ! -e $BASE/st_latest.tgz -o cf_latest.tgz -nt $BASE/cf_latest.tgz -o st_latest.tgz -nt $BASE/st_latest.tgz ] || exit 0
rm -Rvf $BASE.new
mkdir -v $BASE.new
tar -xvf cf_latest.tgz -C $BASE.new
tar -xvf st_latest.tgz -C $BASE.new
cp -av cf_latest.tgz st_latest.tgz $BASE.new/
rm -Rvf $BASE.old /var/lib/spamassassin/compiled.old
[ ! -e /var/lib/spamassassin/compiled ] || mv -v /var/lib/spamassassin/compiled /var/lib/spamassassin/compiled.old
mv -v $BASE.new/compiled /var/lib/spamassassin
mv -v $BASE $BASE.old
mv -v $BASE.new $BASE
