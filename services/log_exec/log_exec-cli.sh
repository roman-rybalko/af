#!/bin/sh

dir="`dirname $0`"
cmd="$@"
res="`echo $cmd | $dir/log_exec.pl`"
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
