package App::HTTPThis;
BEGIN {
  $App::HTTPThis::VERSION = '0.001';
}

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

#  pod2usage("$0: Too many files given.\n")  if @ARGV > 1;
  return $self;
}

sub run {
  my ($self) = @_;

  my $server = Plack::Handler::Standalone->new(port => $self->{port});
  print "Open your browser at http://127.0.0.1:$self->{port}/\n";

  $server->run(Plack::App::Directory->new->to_app);
}

1;


__END__
=pod

=head1 NAME

App::HTTPThis - Export the current directory over HTTP

=head1 VERSION

version 0.001

=head1 SYNOPSIS

    # Not to be used directly, see http_this command

=head1 DESCRIPTION

This class implements all the logic of the L<http_this> command.

=head1 METHODS

=head2 new

Creates a new App::HTTPThis object, parsing the command line arguments
into object attribute values.

=head2 run

Start the HTTP server.

=head1 AUTHOR

Pedro Melo <melo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2010 by Pedro Melo.

This is free software, licensed under:

  The Artistic License 2.0

=cut

