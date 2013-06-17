#!/bin/sh -e

ext=tbz
pkgs="`pkg_info | awk '{print $1}'`"
for pkg in $pkgs
do
    [ -e $pkg.$ext ] || pkg_create -v -b $pkg
done
