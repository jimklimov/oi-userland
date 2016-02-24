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
# Copyright 2016, Jim Klimov. All rights reserved.
#

include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		clamav
### For X.Y.0 versions the TGZ and DIR do not include trailing .0 piece
### But our package version should better have same number of components
COMPONENT_VERSION=	0.99
ifeq ($(words $(subst ., ,$(COMPONENT_VERSION))),2)
 IPS_COMPONENT_VERSION=	$(COMPONENT_VERSION).0
else
 IPS_COMPONENT_VERSION=	$(COMPONENT_VERSION)
endif
### Library files are tagged with unique per-version numbers
COMPONENT_VERSION_LIB_MAJOR=	7
COMPONENT_VERSION_LIB_FULL=	$(COMPONENT_VERSION_LIB_MAJOR).1.1
COMPONENT_SUMMARY=	ClamAV $(IPS_COMPONENT_VERSION) - opensource antivirus toolkit
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH=	\
	sha256:d2792c8cfadd685fffc40b2199679628815df031fd3149ccf961649fc8787ea9
COMPONENT_PROJECT_URL=	http://www.clamav.org/
COMPONENT_ARCHIVE_URL=	\
	http://www.clamav.net/downloads/production/$(COMPONENT_ARCHIVE)
# We need to use non-default User-Agent for the fetch, otherwise we are denied
# to download the source file. (Thanks to Marcel Telka)
COMPONENT_FETCH_USER_AGENT=	fetch

include $(WS_TOP)/make-rules/prep.mk
include $(WS_TOP)/make-rules/configure.mk
include $(WS_TOP)/make-rules/ips.mk

PKG_OPTIONS +=	-D COMPONENT_VERSION_LIB_MAJOR="$(COMPONENT_VERSION_LIB_MAJOR)"
PKG_OPTIONS +=	-D COMPONENT_VERSION_LIB_FULL="$(COMPONENT_VERSION_LIB_FULL)"

CONFIGURE_OPTIONS +=	--sysconfdir=/etc
CONFIGURE_OPTIONS +=	--with-dbdir=/var/clamav/db
CONFIGURE_OPTIONS +=	--with-user=clamav
CONFIGURE_OPTIONS +=	--with-group=clamav
CONFIGURE_OPTIONS +=	--without-gnu-ld
CONFIGURE_OPTIONS +=	--enable-bigstack
CONFIGURE_OPTIONS +=	--enable-readdir_r
CONFIGURE_OPTIONS +=	--with-openssl=/usr
CONFIGURE_OPTIONS +=	--with-zlib=/usr
CONFIGURE_OPTIONS +=	--with-libbz2-prefix=/usr
CONFIGURE_OPTIONS +=	--with-libcurl=/usr
CONFIGURE_OPTIONS +=	--with-xml=/usr

### The clamav-milter requires that libmilter exists (in OI Hipster's
### sendmail-8.14.4, that is only present for 32-bits it seems...)
CONFIGURE_OPTIONS.32 +=	--enable-milter
CONFIGURE_OPTIONS.32 +=	--enable-clamdtop
CONFIGURE_OPTIONS.32 +=	--with-libncurses-prefix=/usr

build:		$(BUILD_32_and_64)

install:	$(INSTALL_32_and_64)

test:		$(NO_TESTS)

BUILD_PKG_DEPENDENCIES =	$(BUILD_TOOLS)

include $(WS_TOP)/make-rules/depend.mk
