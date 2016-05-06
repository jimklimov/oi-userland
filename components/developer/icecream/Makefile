#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source.  A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
#

#
# Copyright (c) 2016 Jim Klimov
#

include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		icecream
COMPONENT_VERSION=	1.1rc2
IPS_COMPONENT_VERSION=	1.1.0.2
COMPONENT_PROJECT_URL=	https://en.opensuse.org/Icecream
COMPONENT_DOCUMENTATION_URL =	https://github.com/icecc/icecream/blob/master/README.md
COMPONENT_SRC= $(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE= $(COMPONENT_VERSION).tar.gz
COMPONENT_ARCHIVE_HASH=	\
  sha256:479d4dd3bc752b3ac5289c9bcfe0270ef3522a325c0945ddb273ded767688958
COMPONENT_ARCHIVE_URL= \
  https://github.com/icecc/icecream/archive/$(COMPONENT_ARCHIVE)
COMPONENT_SUMMARY=	icecc icecream - distributor of preprocessed C/C++/ObjC files across nodes to crowd-build code
COMPONENT_FMRI=		developer/icecc/$(COMPONENT_NAME)
COMPONENT_CLASSIFICATION=	Development/C
COMPONENT_LICENSE=	"GPLv2"
COMPONENT_LICENSE_FILE=	COPYING


include $(WS_MAKE_RULES)/prep.mk
include $(WS_MAKE_RULES)/configure.mk
include $(WS_MAKE_RULES)/ips.mk

PATH=$(GNUBIN):$(USRBINDIR)

COMPONENT_PREP_ACTION = \
    ( cd $(@D) && ./autogen.sh )

COMPONENT_PRE_CONFIGURE_ACTION =	($(CLONEY) $(SOURCE_DIR) $(@D))

CXXFLAGS.32=-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
CFLAGS.32=	-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE

CXXFLAGS+=	$(CXXFLAGS.$(BITS))
CFLAGS +=	$(CFLAGS.$(BITS))

CFLAGS +=	-D_GNU_SOURCE -D__EXTENSIONS__
CXXFLAGS +=	-D_GNU_SOURCE -D__EXTENSIONS__

CXXFLAGS +=	-D_POSIX_PTHREAD_SEMANTICS
CFLAGS +=	-D_POSIX_PTHREAD_SEMANTICS

CONFIGURE_OPTIONS +=	--sysconfdir=$(ETCDIR)

# GSS-API mutual auth
CONFIGURE_OPTIONS +=	--with-auth

# GUIs for monitoring
CONFIGURE_OPTIONS +=	--with-gnome
CONFIGURE_OPTIONS +=	--with-gtk

# common targets
build:          $(BUILD_32_and_64)

install:        $(INSTALL_32_and_64)

test:           $(NO_TESTS)

BUILD_PKG_DEPENDENCIES =	$(BUILD_TOOLS)

include $(WS_MAKE_RULES)/depend.mk
