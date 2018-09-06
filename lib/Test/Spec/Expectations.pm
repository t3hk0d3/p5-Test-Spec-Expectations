package Test::Spec::Expectations;

use 5.006;
use strict;
use warnings;

use Data::Dump qw/pp/;

use Exporter ();

use parent 'Exporter';

use Test::More;
use Test::Deep;
use Test::Trap;

use Test::Spec::Expectations::Matchers::StringMatch;

=head1 NAME

Test::Spec::Expectations - The great new Test::Spec::Expectations!

=head1 VERSION

Version 0.10

=cut

our $VERSION = '0.10';

our @EXPORT = qw(
    expect
    to
    not_to
    be_truthy
    match
);


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Test::Spec::Expectations;

    my $foo = Test::Spec::Expectations->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 expect

=cut

sub expect (&$) {
    my ($coderef, $expectation) = @_;

    my $tb = Test::More->builder;

    my @result = trap { $coderef->() };

    eval {
        $expectation->($trap);
        ok(1);

        1;
    } or do {
        my $error = $@ // 'unknown error';

        my $error_message = $error->{message};

        $error_message = join "\n", map { "\t" . $_ } split /\n/, $error_message;

        $tb->ok(0);
        $tb->diag($error_message);
    };
}

=head2 to

=cut

sub to ($;) {
    my ($expectation) = @_;

    return sub { $expectation->match(@_) };
}

=head2 not_to

=cut

sub not_to ($;) {
    my ($expectation) = @_;

    return sub { !$expectation->match(@_) };
}

=head2 not_to

=cut

sub be_truthy ($) {
    my ($expectation) = @_;
}

sub match ($) {
    Test::Spec::Expectations::Matchers::StringMatch->new(@_)
}

=head1 AUTHOR

Igor Yamolov, C<< <clouster at yandex.ru> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-test-spec-expectations at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-Spec-Expectations>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Test::Spec::Expectations


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-Spec-Expectations>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Test-Spec-Expectations>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/Test-Spec-Expectations>

=item * Search CPAN

L<https://metacpan.org/release/Test-Spec-Expectations>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2018 Igor Yamolov.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Test::Spec::Expectations
