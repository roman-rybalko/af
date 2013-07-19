#!/bin/sh -x
pwd="`pwd`"
[ `basename "$pwd"` = pwd-done ]
touch ../pwd-done-check/flag
