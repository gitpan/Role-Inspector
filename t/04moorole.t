=pod

=encoding utf-8

=head1 PURPOSE

Test that Role::Inspector works with Moo::Role, and
continues to work with Role::Tiny when Moo is loaded into memory.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2014 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

use strict;
use warnings;
use Test::Modern -requires => { 'Moo::Role' => '1.000000' };

use Role::Inspector qw( get_role_info );

is_deeply(
	get_role_info('Local::MooRole'),
	+{
		name     => 'Local::MooRole',
		type     => 'Moo::Role',
		api      => [sort qw( attr set_attr clear_attr _assert_attr delegated meth req )],
		requires => [sort qw( req )],
		provides => [sort qw( attr set_attr clear_attr _assert_attr delegated meth )],
	},
	'can inspect Moo roles',
) or diag explain(get_role_info('Local::MooRole'));

is_deeply(
	get_role_info('Local::RoleTiny'),
	+{
		name     => 'Local::RoleTiny',
		type     => 'Role::Tiny',
		api      => [sort qw( meth req )],
		requires => [sort qw( req )],
		provides => [sort qw( meth )],
	},
	'can inspect Role::Tiny roles',
) or diag explain(get_role_info('Local::RoleTiny'));

done_testing;

