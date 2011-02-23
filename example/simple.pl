#!perl -w
use strict;
use utf8;

sub cat {
    my($x, $y) = @_;
    return $x . $y;
}

no utf8::implicitconvertion;

my $foo = 'あ';
my $bar = 'い';
utf8::encode($bar);

print cat($foo, $bar);

