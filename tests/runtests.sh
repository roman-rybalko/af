#!/bin/sh -ex

testdir=$1
"`dirname $0`"/checktests.sh $testdir

push1d()
{
	local newd
	newd=$1
	oldd="`pwd`"
	cd $newd
}

pop1d()
{
	[ -z "$oldd" ] || cd "$oldd"
	oldd=
}

runtest()
{
	local testdir
	testdir=$1

	if [ -e $testdir/init.sh ]
	then
		push1d $testdir
		./init.sh >init.log 2>&1 && mv init.log init.ok || mv init.log init.fail
		pop1d
	else
		touch $testdir/init.ok
	fi

	if [ -e $testdir/init.ok ]
	then
		if [ -e $testdir/test.sh ]
		then
			push1d $testdir
			./test.sh >test.log 2>&1 && mv test.log test.ok || mv test.log test.fail
			pop1d
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
		push1d $testdir
		./done.sh >done.log 2>&1 || true
		pop1d
	fi

	[ -e $testdir/init.ok ]
	[ -e $testdir/test.ok ]
}

TESTCONF="`pwd`"/$testdir.conf
export TESTCONF
TESTDIR="`pwd`"/$testdir
export TESTDIR
runtest $testdir || true

find $testdir -name init.fail | grep fail && exit 1 || true
find $testdir -name test.fail | grep fail && exit 1 || true
echo "OK (`basename $0`)"
