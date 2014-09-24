#!/usr/bin/perl

use strict;
use warnings;

use MIME::Base64;

print decode_base64(join("", @ARGV));
exit 0;
