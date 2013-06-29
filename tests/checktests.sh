#!/bin/sh -ex

testdir=$1

checktest()
{
	local testdir
	testdir=$1

	if [ -n "$TESTPREFIX" ]
	then
		if expr $testdir : ^$TESTPREFIX || expr $TESTPREFIX : ^$testdir
		then
			true
		else
			return 0
		fi
	fi

	if [ -e $testdir/init.sh ]
	then
		[ -f $testdir/init.sh ]
		[ -r $testdir/init.sh ]
		[ -x $testdir/init.sh ]
	fi

	if [ -e $testdir/test.sh ]
	then
		[ -f $testdir/test.sh ]
		[ -r $testdir/test.sh ]
		[ -x $testdir/test.sh ]
	fi

	if [ -e $testdir/done.sh ]
	then
		[ -f $testdir/done.sh ]
		[ -r $testdir/done.sh ]
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

[ -n "$testdir" ]
[ -d "$testdir" ]
[ -x "$testdir" ]
[ -f $testdir.conf ]
[ -r $testdir.conf ]
checktest $testdir
echo "OK (`basename $0`)"
