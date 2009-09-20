package Example::Response;
use base qw(HTTP::Response);

sub finalize {
    my $self = shift;
       $self->code(200);
}

!!1;
