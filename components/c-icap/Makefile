#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"). You may
# only use this file in accordance with the terms of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source. A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
#

#
# Copyright 2015, Jim Klimov
#

include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		c-icap
COMPONENT_NAME_PROJ=	c-icap
COMPONENT_FMRI=		service/$(COMPONENT_NAME)
COMPONENT_VERSION=	0.4.2
COMPONENT_REVISION=	1
COMPONENT_LICENSE=	GPLv2
COMPONENT_LICENSE_FILE=	COPYING
COMPONENT_PROJECT_URL=	http://$(COMPONENT_NAME_PROJ).sourceforge.net
COMPONENT_SUMMARY=	c-icap is an implementation of an ICAP server
COMPONENT_SRC=		c_icap-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH=	sha256:b138c7d7d9828d54c3307bcfe7b4917911266593832ffc26a60df9a0dfd2511e
COMPONENT_ARCHIVE_URL=	http://downloads.sourceforge.net/$(COMPONENT_NAME_PROJ)/$(COMPONENT_ARCHIVE)

include ../../make-rules/prep.mk
include ../../make-rules/configure.mk
include ../../make-rules/ips.mk

#LDFLAGS +=	-L/usr/gnu/lib -R/usr/gnu/lib

#CFLAGS +=       $(CPP_LARGEFILES)
#LDFLAGS +=      $(LD_Z_DEFS) $(LD_Z_TEXT) -lpthread

CFLAGS +=	  -I$(SOURCE_DIR) -I$(SOURCE_DIR)/include
CONFIGURE_OPTIONS +=    --enable-large-files
CONFIGURE_OPTIONS +=    --enable-sysvipc
CONFIGURE_OPTIONS +=    --sysconfdir=/etc
CONFIGURE_OPTIONS +=    --libexecdir=/usr/lib

PKGLINT=true

PATH=/usr/gnu/bin:/usr/bin

#COMPONENT_PREP_ACTION =        ( cd $(@D) && \
#                                 aclocal -I. && \
#                                 autoheader && \
#                                 libtoolize --force && \
#                                 intltoolize --force --automake && \
#                                 automake -a -f -c &&\
#                                 autoconf )

# common targets
build:          $(BUILD_32_and_64)

install:        $(INSTALL_32_and_64)

include ../../make-rules/depend.mk
