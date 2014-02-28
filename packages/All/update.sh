#!/bin/sh -e

for pkg in `pkg info -q`
do
    [ -e $pkg.* ] || pkg create $pkg
done
pkg repo ..
