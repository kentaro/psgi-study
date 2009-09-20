#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;

use FindBin;
use lib      "$FindBin::Bin/../lib";
use lib glob "$FindBin::Bin/../modules/*/lib";

use Plack::Loader;
use Example::Handler::PSGI;

GetOptions(\my %opts, "impl=s", "help");
$ENV{PLACK_IMPL} = $opts{impl} if $opts{impl};

my $handler = Example::Handler::PSGI->handler('MyApp');
my $impl    = Plack::Loader->auto(%opts);
   $impl->run($handler);
   $impl->run_loop if $impl->can('run_loop');
