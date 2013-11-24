#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif
./init-data.pl # perl storable is not cross-platform-portable
