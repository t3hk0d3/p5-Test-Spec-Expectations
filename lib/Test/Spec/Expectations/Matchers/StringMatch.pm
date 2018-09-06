package Test::Spec::Expectations::Matchers::StringMatch;

use parent 'Test::Spec::Expectations::Matchers::BaseMatcher';

use strict;
use warnings;

use Test::More;

sub match {
    my ($self, $result) = @_;

    my $regexp = $self->{args}[0];

    my $string = $result->return->[0];

    if ($string && $string =~ $regexp) {
        return 1;
    } else {
        die {
            from => $self,
            message => "failed to match " . $self->_dump($string) . ' to pattern ' . $self->_dump($regexp)
        };
    }
}

1;
