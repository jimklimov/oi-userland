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
# Copyright 2016 Jim Klimov <jimklimov@gmail.com>
#

include ../../../../make-rules/shared-macros.mk

COMPONENT_NAME=		source
COMPONENT_VERSION=	2.5
IPS_COMPONENT_VERSION=	$(COMPONENT_VERSION).0
COMPONENT_PROJECT_URL=	http://ufoai.org
COMPONENT_SRC=		ufoai-$(COMPONENT_VERSION)-$(COMPONENT_NAME)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.bz2
COMPONENT_ARCHIVE_HASH= \
	sha256:0c7cc3bc9efeb276f71cbe6ee8ff7c76f98d183de79f1a069fa63059cf182a8f
COMPONENT_FMRI=		games/ufoai/game
COMPONENT_LICENSE=	GPLv2
COMPONENT_LICENSE_FILE=	$(COMPONENT_NAME).license
COMPONENT_SUMMARY=	UFO:AlienInvasion - game code
COMPONENT_CLASSIFICATION="Applications/Games"
COMPONENT_ARCHIVE_URL= \
	http://sourceforge.net/projects/ufoai/files/UFO_AI%202.x/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)

PATH=/usr/gnu/bin:/usr/bin

include $(WS_MAKE_RULES)/prep.mk
include $(WS_MAKE_RULES)/justmake.mk
include $(WS_MAKE_RULES)/ips.mk

COMPONENT_PRE_BUILD_ACTION = \
	( cd $(@D) && ./configure --enable-release )
# Needs to patch egrep
# --enable-sse

build: $(BUILD_32_and_64)

install: $(INSTALL_32_and_64)

test: $(TEST_32_and_64)

BUILD_PKG_DEPENDENCIES =	$(BUILD_TOOLS)

include $(WS_MAKE_RULES)/depend.mk
