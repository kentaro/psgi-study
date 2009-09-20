package Example;
use base qw(Example::Thing);

use Example::Util;
use Example::Stash;
use Example::View;
use Example::Dispatcher;

use Carp qw(croak);
use Encode qw(encode_utf8 is_utf8);

__PACKAGE__->mk_accessors(qw(
    config
    request
    response
    stash
));

sub run {
    my ($class, $env)    = @_;
    my $interface        = $class->httpd_interface;
    my $self             = $class->new;
       $self->config     = load_class("$class\::Config")->new;
       $self->req        = load_class("Example\::Request\::$interface")->new($env);
       $self->res        = load_class("Example\::Response\::$interface")->new;
       $self->stash      = Example::Stash->new;
    my $rule             = load_class("$class\::Dispatcher")->match($self->req);
       $rule->{controller} ||= 'Index';
       $rule->{action}     ||= 'default';
    my $controller_class = load_class("$class\::Controller::$rule->{controller}"),
    my $action           = $rule->{action} || 'default';

    croak qq{no such action: $action} if !$controller_class->can($action);

    my $controller = $controller_class->new;
       $controller->$action($self);
    my $content = $self->res->content;

    if ($content eq '') {
        my $tmpl_impl = $self->config->param('tmpl_impl') || 'TT';
        my $tmpl_opt  = $self->config->param('tmpl_opt')  || {};
        my $tmpl_ext  = $self->config->param('tmpl_ext')  || 'tt';
        my $view      = Example::View->get_impl($tmpl_impl, $tmpl_opt);
        my $template  = "@{[lc $rule->{controller}]}.@{[lc $action]}.$tmpl_ext";
        my $content   = $view->render($template, $self->stash);
           $content   = encode_utf8($content) if is_utf8($content);

        if (!$self->res->content_type) {
            $self->res->content_type('text/html')
        }
        $self->res->content($content);
    }

    $self->res->finalize;
    $self->res;
}

sub req :lvalue { shift->request(@_)  }
sub res :lvalue { shift->response(@_) }
sub httpd_interface { 'PSGI' }

!!1;
