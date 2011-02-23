#!perl -w
use strict;
use Test::More tests => 1;

BEGIN {
    use_ok 'encoding::implicit';
}

diag "Testing encoding::implicit/$encoding::implicit::VERSION";
