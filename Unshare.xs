#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "const-c.inc"
#define _GNU_SOURCE
#include <sched.h>

MODULE = Linux::Unshare		PACKAGE = Linux::Unshare		

INCLUDE: const-xs.inc

int unshare_ns()
	CODE:
		RETVAL = unshare(CLONE_NEWNS);
	OUTPUT:
		RETVAL
	
