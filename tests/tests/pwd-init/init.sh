#!/bin/sh -ex
rm -vf flag
pwd="`pwd`"
[ `basename "$pwd"` = pwd-init ]
touch flag