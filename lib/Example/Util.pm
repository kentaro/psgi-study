package Example::Util;
use base qw(Exporter);

use strict;
use warnings;
use Carp qw(croak);

use UNIVERSAL::require;

our @EXPORT    = qw(load_class);
our @EXPORT_OK = @EXPORT;

sub load_class {
    my $class = shift;
       $class->use or croak(qq{no such class: $class});
       $class;
}

!!1;
