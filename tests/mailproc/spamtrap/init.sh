#!/bin/sh -ex

. "$TESTCONF"

rm -Rf .tmp .out
mkdir .out
cp -rv .init .tmp
