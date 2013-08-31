#!/bin/sh -ex

. `dirname $0`/mailproc.conf

SRCDIR=`dirname $0`
STHOST=`$SRCDIR/ldap.pl -U $LDAP -q hostname -s spamtrap -1`
mkdir $STUPD || true
cd $STUPD
curl --location --fail --remote-time -z db_latest.tgz --cert /etc/ssl/`hostname`.crt --key /etc/ssl/`hostname`.key --capath /etc/ssl/ca https://$STHOST/spamtrap/db_latest.tgz -o db_latest.tgz
curl --location --fail --remote-time -z sa_latest.tgz --cert /etc/ssl/`hostname`.crt --key /etc/ssl/`hostname`.key --capath /etc/ssl/ca https://$STHOST/spamtrap/sa_latest.tgz -o sa_latest.tgz
rm -Rvf $BASE.new
mkdir $BASE.new
tar -zxvf db_latest.tgz -C $BASE.new
tar -zxvf sa_latest.tgz -C $BASE.new
rm -Rvf $BASE.old
mv $BASE $BASE.old
mv $BASE.new $BASE
