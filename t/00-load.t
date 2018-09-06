#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Test::Spec::Expectations' ) || print "Bail out!\n";
}

diag( "Testing Test::Spec::Expectations $Test::Spec::Expectations::VERSION, Perl $], $^X" );
