#!/bin/sh -ex

. "$TESTCONF"

mv .mime/* ../.mime
wait_mime_done ../.mime
