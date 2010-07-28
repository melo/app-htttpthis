package App::HTTPThis;

# ABSTRACT: Export the current directory over HTTP

use strict;
use warnings;
use Plack::App::Directory;
use Plack::Handler::Standalone;
use Getopt::Long;
use Pod::Usage;

=method new

Creates a new App::HTTPThis object, parsing the command line arguments
into object attribute values.

=cut

sub new {
  my $class = shift;
  my $self = bless {port => 7007, root => '.'}, $class;

  GetOptions($self, "help", "man", "port=i") || pod2usage(2);
  pod2usage(1) if $self->{help};
  pod2usage(-verbose => 2) if $self->{man};

  if (@ARGV > 1) {
    pod2usage("$0: Too many roots, only single root supported");
  }
  elsif (@ARGV) {
    $self->{root} = shift @ARGV;
  }

  return $self;
}

=method run

Start the HTTP server.

=cut

sub run {
  my ($self) = @_;

  my $server = Plack::Handler::Standalone->new(port => $self->{port});
  print "Exporting '$self->{root}' available at:\n";
  print "   http://127.0.0.1:$self->{port}/\n";

  $server->run(Plack::App::Directory->new({root => $self->{root}})->to_app);
}

1;

=head1 SYNOPSIS

    # Not to be used directly, see http_this command


=head1 DESCRIPTION

This class implements all the logic of the L<http_this> command.

