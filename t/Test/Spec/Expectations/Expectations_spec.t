use Test::Spec;

use Test::Spec::Expectations;

describe 'Test::Spec::Expectations' => sub {
    it 'does string matching' => sub {
        my $foo = 'groon';

        expect { $foo } to match qr/^goo/ & match qr/l$/ | match qr/^.oo.$/;

        expect { $foo } to match qr/^goon/ & match qr/oob$/;
    };

};

runtests unless caller;
