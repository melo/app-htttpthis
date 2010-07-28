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
  my $self = bless {}, $class;

  GetOptions($self, "help", "man") || pod2usage(2);
  pod2usage(1) if $self->{help};
  pod2usage(-verbose => 2) if $self->{man};

#  pod2usage("$0: Too many files given.\n")  if @ARGV > 1;
  return $self;
}

sub run {
  my ($self) = @_;

  my $server = Plack::Handler::Standalone->new(port => 7007);
  print "Open your browser at http://127.0.0.1:7007/\n";

  $server->run(Plack::App::Directory->new->to_app);
}

1;

__END__
=pod

=head1 NAME

App::HTTPThis - Export the current directory over HTTP

=head1 VERSION

version 0.001

=head1 AUTHOR

Pedro Melo <melo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2010 by Pedro Melo.

This is free software, licensed under:

  The Artistic License 2.0

=cut

