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
# Copyright 2016 Jim Klimov
#

include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=	znapzend
COMPONENT_VERSION=	0.15.7
COMPONENT_SUMMARY=	zfs backup with remote capabilities and mbuffer integration
COMPONENT_DESCRIPTION=	ZnapZend is a ZFS centric backup tool. It relies on snapshot,\
 send and receive todo its work. It has the built-in ability to manage both local\
 snapshots as well as remote copies by thining them out as time progresses.\
 The ZnapZend configuration is stored as properties in the ZFS filesystem itself.
COMPONENT_SRC=	$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH=	\
  sha256:7d2cf9955e058f42a58c19e1cd4c36a972fb4a303a2eba8b23651117e5ec812e
COMPONENT_ARCHIVE_URL=	\
  https://github.com/oetiker/$(COMPONENT_NAME)/releases/download/v$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://github.com/chaos/powerman
COMPONENT_FMRI=	backup/$(COMPONENT_NAME)
COMPONENT_CLASSIFICATION=	Applications/System Utilities
COMPONENT_LICENSE=	GPLv2+
COMPONENT_LICENSE_FILE=	COPYING

#https://github.com/oetiker/znapzend/releases/download/v0.15.7/znapzend-0.15.7.tar.gz

include $(WS_MAKE_RULES)/prep.mk
include $(WS_MAKE_RULES)/configure.mk
include $(WS_MAKE_RULES)/ips.mk


COMPONENT_PRE_CONFIGURE_ACTION =	( $(CLONEY) $(SOURCE_DIR) $(@D) )

# TODO: Post-install - fix "${prefix}" in SMF xml

CONFIGURE_OPTIONS +=	--disable-static
CONFIGURE_OPTIONS +=	--enable-shared

CONFIGURE_OPTIONS +=	--sysconfdir=/etc
CONFIGURE_OPTIONS +=	--enable-svcinstall=/lib/svc/manifest/system

# znapzend is a script, but it can pull some PERL modules and some may be ARCHed
# TODO: package dependency modules as seaprate IPS requirements, and build 32-bit znapzend
build: $(BUILD_32_and_64)

install: $(INSTALL_32_and_64)

test: $(TEST_32_and_64)

