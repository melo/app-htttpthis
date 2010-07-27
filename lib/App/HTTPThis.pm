package App::HTTPThis;

use strict;
use warnings;
use Plack::Builder;
use Twiggy::Server;

sub new {
  my $class = shift;
  
  return bless {}, $class;
}

sub run {
  my ($self) = @_;

  my $server = Twiggy::Server->new(port => 7007);
  print "Open your browser at http://127.0.0.1:7007/\n";
  
  $server->run(builder {
    Plack::Middleware::Status
    enable "Plack::Middleware::Static",
        path => qr{^/}, root => '.';
  });
}

1;
