package MyApp::Controller::Index;
use base qw(Example::Controller);

sub default {
    my ($self, $ctx) = @_;
    $ctx->stash->param(
        foo => 'foo',
        bar => 'bar',
    );
}

!!1;
