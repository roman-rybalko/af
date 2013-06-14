#!/bin/sh -ex

testdir=$1
[ -n "$testdir" ]
[ -d "$testdir" ]

checktest()
{
	local testdir
	testdir=$1

	if [ -e $testdir/init.sh ]
	then
		[ -f $testdir/init.sh ]
		[ -x $testdir/init.sh ]
	fi

	if [ -e $testdir/test.sh ]
	then
		[ -f $testdir/test.sh ]
		[ -x $testdir/test.sh ]
	fi

	if [ -e $testdir/done.sh ]
	then
		[ -f $testdir/done.sh ]
		[ -x $testdir/done.sh ]
	fi

	rm -f $testdir/init.log $testdir/test.log $testdir/done.log \
		$testdir/init.ok $testdir/test.ok \
		$testdir/init.fail $testdir/test.fail

	for t in $testdir/*
	do
		[ ! -d $t ] || checktest $t
	done
}

runtest()
{
	local testdir
	testdir=$1

	if [ -e $testdir/init.sh ]
	then
		$testdir/init.sh >$testdir/init.log 2>&1 \
			&& mv $testdir/init.log $testdir/init.ok \
			|| mv $testdir/init.log $testdir/init.fail
	else
		touch $testdir/init.ok
	fi

	if [ -e $testdir/init.ok ]
	then
		if [ -e $testdir/test.sh ]
		then
			$testdir/test.sh >$testdir/test.log 2>&1 \
				&& mv $testdir/test.log $testdir/test.ok \
				|| mv $testdir/test.log $testdir/test.fail
		else
			touch $testdir/test.ok
		fi

	fi

	if [ -e $testdir/test.ok ]
	then
		for t in $testdir/*
		do
			if [ -d $t ]
			then
				runtest $t || break
			fi
		done
	fi

	if [ -e $testdir/done.sh ]
	then
		$testdir/done.sh >$testdir/done.log 2>&1 || true
	fi

	[ -e $testdir/init.ok ]
	[ -e $testdir/test.ok ]
}

checktest $testdir
runtest $testdir || true
find $testdir -name init.fail | grep fail && exit 1 || true
find $testdir -name test.fail | grep fail && exit 1 || true
echo "OK"
