package Example::Handler::PSGI;
use base qw(Example::Handler);
use strict;
use warnings;

use Example::Util;

use Carp qw(croak);

sub handler {
    my $class     = shift;
    my $namespace = shift or $ENV{EXAMPLE_NAMESPACE}
        or croak q{namespace not determined};
    my $app       = load_class($namespace);

    sub { $app->run(shift)->result };
}

!!1;
