package Example::View::TT;
use base qw(Example::View);

use Template;

__PACKAGE__->mk_accessors(qw(
    tt
));

sub init {
    my ($self, $args) = @_;
    $self->tt = Template->new($args);
}

sub render {
    my ($self, $template, $params) = @_;
    $self->tt->process($template, $params, \my $result);
    $result;
}

1;
