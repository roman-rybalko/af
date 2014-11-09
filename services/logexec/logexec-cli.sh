#!/bin/sh

dir="`dirname $0`"
cmd="$@"
res="`echo $cmd | $dir/logexec.pl`"
case "$res" in
	OK*)
		exit 0
	;;
	FAIL:*)
		echo $res
		exit 1
	;;
	*)
		echo $res
		exit 2
	;;
esac
