#!/bin/sh -ex
. ./remote.conf

pkg_delete `pkg_info -E 'p5-Mail-SpamAssassin-*'` || true

rm -Rvf /usr/local/advancedfiltering/spamtrap /usr/local/advancedfiltering/https/spamtrap

rmuser -yv spamtrap || true
rmuser -yv spamd || true
