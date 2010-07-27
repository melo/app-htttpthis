package App::HTTPThis;

use strict;
use warnings;
use Plack::App::Directory;
use Twiggy::Server;

sub new {
  my $class = shift;
  
  return bless {}, $class;
}

sub run {
  my ($self) = @_;

  my $server = Twiggy::Server->new(port => 7007);
  print "Open your browser at http://127.0.0.1:7007/\n";
  
  $server->run(Plack::App::Directory->new->to_app);
}

1;
