#!/bin/sh -ex
. ./remote.conf

pkg delete -y exim || true
pkg autoremove -y
