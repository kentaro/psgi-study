package Example::Controller;
use base qw(Example::Thing);

sub default {
    my ($self, $ctx) = @_;
    $ctx->res->content('default action');
}

!!1;
