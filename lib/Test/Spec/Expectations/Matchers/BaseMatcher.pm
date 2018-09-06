package Test::Spec::Expectations::Matchers::BaseMatcher;

use strict;
use warnings;

use overload
    '&' => \&_overload_and,
    '|' => \&_overload_or;

use Data::Dumper qw/Dumper/;

sub new {
    my ($class, @args) = @_;

    return bless({ args => [ @args ] }, $class);
}

sub match {
    my ($self, $result) = @_;

    die 'Method not implemented!';
}

sub _overload_and {
    require Test::Spec::Expectations::Matchers::AndMatcher;

    Test::Spec::Expectations::Matchers::AndMatcher->new(@_);
}

sub _overload_or {
    require Test::Spec::Expectations::Matchers::OrMatcher;

    Test::Spec::Expectations::Matchers::OrMatcher->new(@_); 
}

sub _dump {
    my ($self, @values) = @_;

    local $Data::Dumper::Terse = 1;
    local $Data::Dumper::Indent = 0;

    return Dumper(@values); 
}

1;
