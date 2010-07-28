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
  my $self = bless {port => 7007}, $class;

  GetOptions($self, "help", "man", "port=i") || pod2usage(2);
  pod2usage(1) if $self->{help};
  pod2usage(-verbose => 2) if $self->{man};

  return $self;
}

sub run {
  my ($self) = @_;

  my $server = Plack::Handler::Standalone->new(port => $self->{port});
  print "Open your browser at http://127.0.0.1:$self->{port}/\n";

  $server->run(Plack::App::Directory->new->to_app);
}

1;
