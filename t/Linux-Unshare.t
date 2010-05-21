use strict;
use warnings FATAL => 'all';

use Test::More tests => 4;
BEGIN { use_ok('Linux::Unshare', qw(unshare CLONE_NEWNS CLONE_FS)) };

SKIP: {
	skip "Should be root to test mount --bind", 1 if $<;
	my $pid = fork();
	if ($pid) {
		waitpid($pid, 0);
	} else {
		unshare(CLONE_FS) or die $!;
		system("mount --bind /dev/null $0") and die;
		exit;
	}
	my $res = `umount $0 2>&1`;
	isnt($res, '');
};

is(unshare(CLONE_NEWNS), $< ? undef : 1);
is(unshare(CLONE_FS), 1);
