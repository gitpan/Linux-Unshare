use strict;
use warnings FATAL => 'all';

use Test::More tests => 3;
BEGIN { use_ok('Linux::Unshare', qw(unshare_ns)) };

SKIP: {
	skip "Should be root to test mount --bind", 1 if $<;
	my $pid = fork();
	if ($pid) {
		waitpid($pid, 0);
	} else {
		unshare_ns();
		system("mount --bind /dev/null $0") and die;
		exit;
	}
	my $res = `umount $0 2>&1`;
	isnt($res, '');
};

is(unshare_ns(), $< ? -1 : 0);
