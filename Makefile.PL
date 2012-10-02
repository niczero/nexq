use 5.010001;

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'RexQ',
  VERSION_FROM => 'lib/Rexq.pm',
  ABSTRACT     => 'Asynchronous job execution',
  AUTHOR       => 'Nic Sandfield <niczero@cpan.org>',
  LICENSE      => 'artistic_2',
  META_MERGE   => {
    requires  => {perl => '5.010001', Mojolicious => '3.33'},
    resources => {
      homepage    => 'http://niczero.github.com/rexq',
      license     => 'http://www.opensource.org/licenses/artistic-license-2.0',
      repository  => 'http://github.com/niczero/rexq',
      bugtracker  => 'http://github.com/niczero/rexq/issues'
    },
    no_index => {directory => ['test']}
  },
  EXE_FILES => ['bin/queues'],
  test => {TESTS => 'test/*.t'}
);
