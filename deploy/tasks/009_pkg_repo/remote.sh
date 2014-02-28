#!/bin/sh -ex
. ./remote.conf

rm -vf /etc/pkg/*
tar -xvf etc_pkg.tgz -C /etc/pkg
pkg update
