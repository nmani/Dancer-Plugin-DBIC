#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Dancer::Plugin::DBIC' ) || print "Bail out!
";
}

diag( "Testing Dancer::Plugin::DBIC $Dancer::Plugin::DBIC::VERSION, Perl $], $^X" );
