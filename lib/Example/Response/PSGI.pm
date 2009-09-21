package Example::Response::PSGI;
use base qw(
    Plack::Response
    Example::Response
);

use Scalar::Util qw(blessed);

sub result { shift->finalize(@_) }
sub content {
    my ($self, $content) = @_;

    if (defined $content) {
        if (ref($content) eq 'GLOB' || (Scalar::Util::blessed($content) && $content->can('getline'))) {
            $self->body($content);
        }
        else {
            $self->body([$content]);
        }
    }

    $self->body;
}

!!1;
