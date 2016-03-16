#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#
# Copyright (c) 2013 Louis M. Picciano. All rights reserved.
# Copyright (c) 2016 Jim Klimov
#

include ../../../../make-rules/shared-macros.mk

COMPONENT_NAME			= tcl-sqlite
COMPONENT_VERSION		= 3.11.1
TARBALL_VERSION			= 3110100
COMPONENT_SRC			= sqlite-autoconf-$(TARBALL_VERSION)
COMPONENT_ARCHIVE		= $(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH	= \
	sha256:533ff1d0271c2e666f01591271cef01a31648563affa0c95e80ef735077d4377
COMPONENT_ARCHIVE_URL=  http://www.sqlite.org/2016/$(COMPONENT_ARCHIVE)
COMPONENT_SUMMARY		= in-process SQL database engine library - tcl files
COMPONENT_PROJECT_URL	= http://www.sqlite.org/

include $(WS_TOP)/make-rules/prep.mk
include $(WS_TOP)/make-rules/configure.mk
include $(WS_TOP)/make-rules/ips.mk

CFLAGS			+= -D_POSIX_PTHREAD_SEMANTICS
CFLAGS			+= -DNDEBUG
CFLAGS			+= -DSQLITE_SECURE_DELETE 
CFLAGS			+= -DSQLITE_ENABLE_FTS3 
CFLAGS			+= -DUSE_PREAD 
CFLAGS			+= -DHAVE_USLEEP
CFLAGS			+= -DHAVE_FDATASYNC
CFLAGS			+= -DHAVE_STATVFS 
CFLAGS			+= -DSQLITE_ENABLE_UNLOCK_NOTIFY
CFLAGS			+= -DSQLITE_ENABLE_STAT2

CONFIGURE_SCRIPT=       $(SOURCE_DIR)/tea/configure

CONFIGURE_OPTIONS	+= --enable-shared
CONFIGURE_OPTIONS.32	+= --with-tcl="/usr/lib"
CONFIGURE_OPTIONS.64	+= --with-tcl="/usr/lib/$(MACH64)"
CONFIGURE_OPTIONS.64	+= LIBS="-m64"

include $(WS_TOP)/make-rules/shared-targets.mk

build:		$(BUILD_32) $(BUILD_64)

install:	$(INSTALL_32) $(INSTALL_64)

test:		$(TEST_32) $(TEST_64)

BUILD_PKG_DEPENDENCIES =	$(BUILD_TOOLS)

include $(WS_TOP)/make-rules/depend.mk
