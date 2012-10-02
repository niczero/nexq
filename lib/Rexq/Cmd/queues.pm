package Mojolicious::Command::queues;
use Mojo::Base 'Mojolicious::Command';

use Rexq;
use Rexq::Failures;
require Data::Dump;

has description => qq{Output current status of queues.\n};
has usage => <<"EOT";
usage: $0 queues <namespace>

  rexecute queues test
EOT

sub run {
  my ($self, @args) = @_;

  $self->_options(
    \@args,
    'v|verbose=s' => \(my $verbose = '')
  );
  die $self->usage unless my $namespace = pop @args;

  my $server = '127.0.0.1:6379';
  my $r = Rexq->new(
    engine => 'Redis',
    server => $server,
    namespace => $namespace
  );
  die sprintf q{Failed to find redis server (%s)}, $server
    unless $r->redis->ping;

  my @queues = $r->queues;
  if (scalar @queues) {
    foreach my $q (@queues) {
      say 'Queue:  ', $q, "\tSize:  ", $r->size($q);
      my @jobs = $r->peek($q, 0, $r->size($q));
      foreach my $j (@jobs) {
        say '  class: ', $j->class;
        say '  args:  ', join ', ', @{$j->args};
      }
    }
  }
  else {
    say 'Queue:  (none)', "\tSize:  0"
  }

  my $count = $r->failures->count;
  my @failures = $r->failures->all(0, $count);
  say '';
  say 'Failures:  ', $count;
  foreach my $f (@failures) {
    say '  queue:     ', $f->{queue};
    say '  error:     ', $f->{error};
    say '  exception: ', $f->{exception};
    say '  failed:    ', $f->{failed_at};
    say '  retried:   ', ($f->{retried_at} || '');
    say '  payload:   ', Data::Dump::dump($f->{payload});
  }
);
}

1;
__END__

=pod

=head1 Name

=head1 Synopsis

=head1 Description

=head1 Attributes

=head1 Methods

=head1 Diagnostics

=head1 Configuration and environment

=head1 Dependencies and incompatibilities

=head1 Bugs and limitations

=cut

