package encoding::implicit;
use 5.008_001;
use strict;
use warnings;

our $VERSION = '0.01';

use Encode ();
use Carp   ();

my $ascii = Encode::find_encoding('us-ascii')
    or die "encoding 'us-ascii' not found";
my $latin1 = Encode::find_encoding('iso-8859-1')
    or die "encoding 'iso-8859-1' not found";

my $instance = bless {}, __PACKAGE__;

sub unimport {
    ${^ENCODING} = $instance;
    return;
}

sub cat_decode {
    shift;
    $latin1->cat_decode(@_);
}

sub decode {
    shift;
    my $wide_chars = 0;
    my $text = $ascii->decode($_[0],
        sub { $wide_chars++; sprintf '\x{%04X}', @_ });

    if($wide_chars) {
        Carp::croak("Bytes ($text) implicitly upgraded into wide characters");
    }
    return $text;
}

sub name { 'iso-8859-1' }

1;
__END__

=head1 NAME

encoding::implicit - Globally disable implicit encoding conversions

=head1 VERSION

This document describes encoding::implicit version 0.01.

=head1 SYNOPSIS

    no encoding::implicit; # effects on global

=head1 DESCRIPTION

This is a variation of C<encoding::warnings>, which warns on implicit encoding
conversions. The difference is that this pragma croaks on IEC instead of
warnings and effects on global instead of lexical.

=head1 DEPENDENCIES

Perl 5.8.1 or later.

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 SEE ALSO

L<encoding::warnings>

L<Encode>

L<perlunifaq>

=head1 AUTHOR

Fuji, Goro (gfx) E<lt>gfuji@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2011, Fuji, Goro (gfx). All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
