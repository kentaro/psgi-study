package Example::Controller::Index;
use base qw(Example::Controller);

sub default {
    my ($self, $ctx) = @_;
    $ctx->res->content('Hello World');
}

!!1;
