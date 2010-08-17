package Dancer::Plugin::DBIC;

use strict;
use warnings;

use Carp qw/ croak /;
use Dancer ':syntax';
use Dancer::Plugin;
use DBIx::Class::Schema::Loader qw/ make_schema_at /;

=head1 NAME

Dancer::Plugin::DBIC - easy access to DBIx::Class in Dancer

=cut

our $VERSION = '0.01';
$VERSION = eval $VERSION;

my $settings = plugin_setting();
$settings->{dsn} || croak 'You need a DSN retard';
$settings->{user} || 'root';$settings->{password} || '';
$settings->{debug} || 1;
$settings->{dump_dir} || './lib';
my $module = $settings->{schema} || 'My::Schema';

my $connect_info = [$settings->{dsn}, $settings->{user}, $settings->{password}];

# Generate DBIC at first runtime? Probably a really bad idea?
make_schema_at(
	       $settings->{schema},
	       {debug => $settings->{debug}, dump_directory => $settings->{dump_dir}},
	       $connect_info
	       ,) || croak 'Making the schema files has failed.';

eval {
    (my $file = $module) =~ s!::!/!g;
    require $file . '.pm';
    $module->import();
    1;
} or do {
    my $error = $@;
    print "Shit has hit the fan: $error";
};

my $schema = $module->connect(@{$connect_info});

register dbic => sub {  
  return $schema;
};

register_plugin;


1;

__END__

=head1 SYNOPSIS

use Dancer;
use Dancer::Plugin::DBIC;

get '/' => sub {

    my $count = dbic->resultset('MyTable')->count();
    return $count;

};

=head1 CONFIG

Inside config.yml, development.yml/production.yml. 
plugins:
  DBIC:
    dsn: "dbi:mysql:mydb"
    user: "username"
    password: "mypassword"
    schema: "My::Schema"
    debug: 1
    dump_dir: "./lib"

=head1 LIMITATIONS

Alpha quality. Stuff WILL change.

The schema files are generated at initial runtime. This is suboptimal and not recommended. Will be changed later.

Currenty is only supports access to one 'schema' in the database sense.  Support for multiple schemas
will be added later or do it yourself.

=head1 EXPORT

=head1 AUTHOR

Naveen Manivannan, C<< <nmani at nashresearch.com> >>

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Dancer::Plugin::DBIC

=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2010 Naveen Manivannan.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
