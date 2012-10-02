use Mojo::Base -strict;
use Test::More tests => 1;

BEGIN {
	use_ok('Rexq');
}

diag "Testing Rexq $Rexq::VERSION, Perl $], $^X";
