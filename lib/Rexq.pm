package Rexq;
use Mojo::Base -base;

our $VERSION = '0.001';

sub new {
  my ($class, %param) = @_;
  my $self = $class->SUPER::new(%param);
  $class = ref $class || $class;
  return bless $self => $class;
}

# ------------
# Attributes
# ------------

has 'namespace';

# ------------
# Public methods
# ------------

# ------------
# Private methods
# ------------

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

