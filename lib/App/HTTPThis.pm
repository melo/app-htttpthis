package App::HTTPThis;

# ABSTRACT: Export the current directory over HTTP

use strict;
use warnings;
use Plack::App::Directory;
use Plack::Handler::Standalone;
use Getopt::Long;
use Pod::Usage;

sub new {
  my $class = shift;
  my $self = bless {}, $class;

  GetOptions($self, "help", "man") || pod2usage(2);
  pod2usage(1) if $self->{help};
  pod2usage(-verbose => 2) if $self->{man};

  return $self;
}

sub run {
  my ($self) = @_;

  my $server = Plack::Handler::Standalone->new(port => 7007);
  print "Open your browser at http://127.0.0.1:7007/\n";

  $server->run(Plack::App::Directory->new->to_app);
}

1;
