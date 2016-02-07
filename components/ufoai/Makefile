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

include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		ufoai
COMPONENT_VERSION=	2.5
IPS_COMPONENT_VERSION=	$(COMPONENT_VERSION).0
COMPONENT_PROJECT_URL=	http://ufoai.org
COMPONENT_FMRI=		games/ufoai
COMPONENT_LICENSE=	GPLv2
COMPONENT_LICENSE_FILE=	$(COMPONENT_NAME).license
COMPONENT_SUMMARY=	UFO:AlienInvasion is an open source turn-based game inspired by classic titles
COMPONENT_CLASSIFICATION="Applications/Games"

include $(WS_TOP)/make-rules/prep.mk
include $(WS_TOP)/make-rules/ips.mk

SUBS = game
#SUBS += mappack
#SUBS += data

prep::
	for SUB in $(SUBS) ; do \
	  ( cd "$(WS_TOP)/components/$(COMPONENT_NAME)/$$SUB" && gmake $@ ) || exit $$?; \
	done ; exit 0

clean::
	for SUB in $(SUBS) ; do \
	  ( cd "$(WS_TOP)/components/$(COMPONENT_NAME)/$$SUB" && gmake $@ ) || exit $$?; \
	done ; exit 0

clobber::
	for SUB in $(SUBS) ; do \
	  ( cd "$(WS_TOP)/components/$(COMPONENT_NAME)/$$SUB" && gmake $@ ) || exit $$?; \
	done ; exit 0

parfait:
	for SUB in $(SUBS) ; do \
	  ( cd "$(WS_TOP)/components/$(COMPONENT_NAME)/$$SUB" && gmake $@ ) || exit $$?; \
	done ; exit 0

build:
	for SUB in $(SUBS) ; do \
	  ( cd "$(WS_TOP)/components/$(COMPONENT_NAME)/$$SUB" && gmake $@ ) || exit $$?; \
	done ; exit 0

install:
	for SUB in $(SUBS) ; do \
	  ( cd "$(WS_TOP)/components/$(COMPONENT_NAME)/$$SUB" && gmake $@ ) || exit $$?; \
	done ; exit 0

test:
	for SUB in $(SUBS) ; do \
	  ( cd "$(WS_TOP)/components/$(COMPONENT_NAME)/$$SUB" && gmake $@ ) || exit $$?; \
	done ; exit 0

publish: build install $(PUBLISH_STAMP)
	for SUB in $(SUBS) ; do \
	  ( cd "$(WS_TOP)/components/$(COMPONENT_NAME)/$$SUB" && gmake $@ ) || exit $$?; \
	done ; exit 0

BUILD_PKG_DEPENDENCIES =	$(BUILD_TOOLS)

include $(WS_TOP)/make-rules/depend.mk
