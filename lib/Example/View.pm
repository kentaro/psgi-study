package Example::View;
use base qw(Example::Thing);

use Example::Util;

use UNIVERSAL::require;

sub render { die "render() method should be implemented by subclass" }

sub get_impl {
    my ($class, $impl, $opt) = @_;
    my $view = load_class(sprintf('%s::%s', __PACKAGE__, $impl));
       $view->new($opt);
}

!!1;
