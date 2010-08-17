use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Dancer::Plugin::DBIC',
    AUTHOR              => q{Naveen Manivannan <nmani@nashresearch.com>},
    VERSION_FROM        => 'lib/Dancer/Plugin/DBIC.pm',
    ABSTRACT_FROM       => 'lib/Dancer/Plugin/DBIC.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
	'Carp' => 0,
	'Dancer' => 1.175,
	'DBIx::Class' => 0.08123,
	'DBIx::Class::Schema::Loader' => 0.07001,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Dancer-Plugin-DBIC-*' },
);
