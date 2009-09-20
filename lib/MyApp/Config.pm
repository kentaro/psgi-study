package MyApp::Config;
use base qw(Example::Config);

use Path::Class qw(dir);
my $root = dir(__FILE__)->parent->parent->parent;

sub init {
    my ($self, $args) = @_;
    $self->param(
        tmpl_opt => {
            INCLUDE_PATH => $root->subdir('templates'),
        },
    );
}

!!1;
