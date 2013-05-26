#!/bin/sh -ex

tasklist=$1
hostpath=$2

[ -n "$tasklist" ]
[ -d $tasklist ]
for t in $tasklist/*
do
	[ -d $t ]
	[ -x $t/local.sh ]
	[ -x $t/remote.sh ]
done

[ -n "$hostpath" ]
[ -f $hostpath ]
[ ! -e $hostpath.ok ]
[ ! -e $hostpath.fail ]

if [ -e $hostpath.pw ]
then
	[ -f $hostpath.pw ]
	sshprefix="./sshpass.sh $hostpath.pw"
	sshopt1="-o StrictHostKeyChecking=no"
	sshuser=root
else
	sshuser=deploy
fi

tasks="`for t in $tasklist/*; do basename $t; done | sort`"
host=`basename $hostpath`
localworkdir="`pwd`"

>$hostpath.log
localtaskdir=`mktemp -d /tmp/deploy-$host-XX`
for t in $tasks
do
	cd "$localworkdir"
	cp -a $tasklist/$t $localtaskdir/
	cd $localtaskdir/$t
	echo "LOCAL TASK: $t"
	if ./local.sh $host
	then
		echo "LOCAL RESULT: $t: OK"
	else
		result=$?
		echo "LOCAL RESULT: $t: FAIL ($result)"
		cd "$localworkdir"
		mv $hostpath.log $hostpath.fail
		rm -R $localtaskdir
		exit $result
	fi
done 2>&1 >>"$localworkdir/$hostpath.log"
cd "$localworkdir"

remotetaskdir=`$sshprefix ssh $sshopt1 $sshuser@$host mktemp -d /tmp/deploy-XX | tr -d '[[:space:]]'`
if [ -z "$remotetaskdir" ]
then
	echo "ssh failed" >>$hostpath.log
	mv $hostpath.log $hostpath.fail
	rm -R $localtaskdir
	exit 1
fi
[ ${#remotetaskdir} -eq 14 ]
$sshprefix ssh $sshuser@$host test -d $remotetaskdir
$sshprefix scp -r $localtaskdir/* remoterun.sh $sshuser@$host:$remotetaskdir
$sshprefix ssh $sshuser@$host $remotetaskdir/remoterun.sh $tasks 2>&1 >>$hostpath.log && mv $hostpath.log $hostpath.ok || mv $hostpath.log $hostpath.fail
$sshprefix ssh $sshuser@$host rm -R $remotetaskdir
rm -R $localtaskdir
