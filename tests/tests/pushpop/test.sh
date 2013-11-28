#!/bin/sh -ex

push1d()
{
	local newd
	newd=$1
	oldd=`pwd`
	cd $newd
}

pop1d()
{
	[ -z "$oldd" ] || cd $oldd
	oldd=
}

mkdir pushpoptest
d=`pwd`
push1d pushpoptest
[ `pwd` = $d/pushpoptest ]
pop1d
[ `pwd` = $d ]
pop1d
[ `pwd` = $d ]
rmdir pushpoptest
echo "OK (`basename $0`)"
