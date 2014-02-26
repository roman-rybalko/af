#!/bin/sh -ex
. ./remote.conf

pkg delete -y p5-Mail-SpamAssassin || true
pkg autoremove -y

rm -Rvf /usr/local/advancedfiltering/spamtrap /usr/local/advancedfiltering/https/spamtrap

rmuser -yv spamtrap || true
rmuser -yv spamd || true
