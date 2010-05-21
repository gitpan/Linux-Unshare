#ifndef __linux
#error "No linux. Compile aborted."
#endif

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "const-c.inc"
#define _GNU_SOURCE
#include <sched.h>

MODULE = Linux::Unshare		PACKAGE = Linux::Unshare

INCLUDE: const-xs.inc

SV *
unshare(flags)
	int flags;
	CODE:
		ST(0) = sv_newmortal();
		if(unshare(flags) == 0)
			sv_setiv(ST(0), 1);
