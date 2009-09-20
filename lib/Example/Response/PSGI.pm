package Example::Response::PSGI;
use base qw(Example::Response);

sub result {
    my $self = shift;
    [
        $self->code,
        [
            map {
                $_, $self->headers->header($_);
            } $self->headers->header_field_names
        ],
        [ $self->content ],
    ];
}

!!1;
