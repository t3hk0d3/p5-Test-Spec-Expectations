package Test::Spec::Expectations::Matchers::AndMatcher;

use parent 'Test::Spec::Expectations::Matchers::BaseMatcher';

use strict;
use warnings;

use Data::Dump qw/pp/;

sub match {
    my ($self, $result) = @_;
    my ($a, $b) = @{$self->{args}};

    my @errors;

    eval { $a->match($result) } or do { push @errors, $@ };
    eval { $b->match($result) } or do { push @errors, $@ };

    if (@errors) {
        my $message = join " AND\n", map { $_->{message} } @errors;

        die {
            from => $self, message => $message,
        };
    }

    return 1;
}

1;
