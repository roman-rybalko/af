#!/bin/sh -ex

tasklist=$1
hostlist=$2

[ -n "$tasklist" ]
[ -d $tasklist ]
for t in $tasklist/*
do
	[ -d $t ]
	[ -x $t/local.sh ]
	[ -x $t/remote.sh ]
done

[ -n "$hostlist" ]
[ -d $hostlist ]

for h in $hostlist/*
do
	[ -f $h ]
done

[ -f deploy.keytab ]

KRB5CCNAME=FILE:/tmp/krb5cc_deploy
export KRB5CCNAME
kinit -t deploy.keytab deploy

unset SSH_AUTH_SOCK

./sched.sh "./run.sh $tasklist" 10 $hostlist/*
