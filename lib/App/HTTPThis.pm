package App::HTTPThis;

# ABSTRACT: Export the current directory over HTTP

use strict;
use warnings;
use Plack::App::Directory;
use Plack::Handler::Standalone;

sub new {
  my $class = shift;

  return bless {}, $class;
}

sub run {
  my ($self) = @_;

  my $server = Plack::Handler::Standalone->new(port => 7007);
  print "Open your browser at http://127.0.0.1:7007/\n";

  $server->run(Plack::App::Directory->new->to_app);
}

1;
