#!/bin/sh -e

ext=tbz
pkgs="`for p in ../All/*.$ext; do basename $p; done | sort`"
for p in $pkgs
do
	n=`echo $p | sed -E 's/-[^-]+$//'`
	rm -f $n.$ext
	ln -sv ../All/$p $n.$ext
done
