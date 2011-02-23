#!perl -w
use strict;
use utf8;

use Test::More;

sub cat {
    my($x, $y) = @_;
    return $x . $y;
}

no encoding::implicit; #  effect on global

my $foo = 'あ';
my $bar = 'い';

is cat($foo, $bar), 'あい';
is $foo, 'あ';
is $bar, 'い';

utf8::encode($bar);

is eval { cat($foo, $bar) }, undef;

my $e = $@;
like $e, qr/implicitly upgraded into wide characters/;
like $e, do { my $x = quotemeta q/\x{00E3}\x{0081}\x{0084}/; qr/$x/ };

done_testing;
