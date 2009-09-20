package Example::Thing;
use strict;
use warnings;
use base qw(
    Class::Accessor::Lvalue::Fast
    Class::Data::Inheritable
);

sub import {
    require strict;   strict->import;
    require warnings; warnings->import;
    require utf8;     utf8->import;
}

sub new {
    my ($class, $args) = @_;
    my $self = $class->SUPER::new($args);
    my $init = $self->can('init') || $self->can('initialize');
    $init->($self, $args) if $init;
    $self;
}

sub param {
    my $self = shift;
    if (@_ == 1) {
        my $key = shift;
        return $self->{$key};
    }
    elsif (@_ && @_ % 2 == 0) {
        my %args = @_;
        while (my ($key, $value) = each %args) {
            $self->{$key} = $value;
        }
        return $self;
    }
    else {
        keys %$self;
    }
}

!!1;
