#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL)". You may
# only use this file in accordance with the terms of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source. A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
#

#
# Copyright 2016 Jim Klimov
#

include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		serf
COMPONENT_VERSION=	1.3.8
COMPONENT_PROJECT_URL=	https://serf.apache.org/
COMPONENT_SUMMARY=	SERF, a high-performance HTTP-client library built on APR
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.bz2
COMPONENT_ARCHIVE_HASH=	\
    sha256:e0500be065dbbce490449837bb2ab624e46d64fc0b090474d9acaa87c82b2590
COMPONENT_ARCHIVE_URL=	https://archive.apache.org/dist/$(COMPONENT_NAME)/$(COMPONENT_ARCHIVE)
COMPONENT_FMRI=		library/serf
COMPONENT_CLASSIFICATION=	Web Services/Application and Web Servers
COMPONENT_LICENSE_FILE=	serf.license
COMPONENT_LICENSE=	Apache

include $(WS_TOP)/make-rules/prep.mk
include $(WS_TOP)/make-rules/ips.mk

PATH=/usr/gnu/bin:/usr/bin
# This build requires that the "scons" component is installed

CLEAN_PATHS+= $(BUILD_DIR)

LIBDIR.32=/usr/lib
LIBDIR.64=/usr/lib/$(MACH64)

CFLAGS += -D__EXTENSIONS__

$(BUILD_DIR_32)/.built: BITS=32
$(BUILD_DIR_64)/.built: BITS=64
COMPONENT_BUILD_ARGS += BITS=$(BITS)

$(BUILD_DIR_32)/.installed: BITS=32
$(BUILD_DIR_64)/.installed: BITS=64
COMPONENT_INSTALL_ARGS += BITS=$(BITS)

# see the README.res for building and installation details
$(BUILD_DIR_$(BITS))/.built:	$(SOURCE_DIR)/.prep
	$(RM) -r $(@D) ; $(MKDIR) $(@D)
	$(CLONEY) $(SOURCE_DIR) $(@D)
	cd $(@D) && \
		scons PREFIX=/usr LIBDIR="$(LIBDIR.$(BITS))" CFLAGS="$(CFLAGS)" LINKFLAGS="$(LDFLAGS)" CC="$(CC)" CPPFLAGS="$(CPPFLAGS)"
	$(TOUCH) $@

$(BUILD_DIR_$(BITS))/.installed:	$(BUILD_DIR_$(BITS))/.built
	mkdir -p $(PROTO_DIR)
	cd $(@D) && \
		scons install --install-sandbox=$(PROTO_DIR)
	cd $(PROTO_DIR)/usr && if [ -d ./man ]; then mkdir -p share && mv -f man share || exit ; fi
	$(TOUCH) $@

build:      $(BUILD_32_and_64) Makefile

install:    $(INSTALL_32_and_64) Makefile

#build:  	$(BUILD_DIR)/$(MACH32)/.built $(BUILD_DIR)/$(MACH64)/.built Makefile

#install:	$(BUILD_DIR)/$(MACH32)/.installed $(BUILD_DIR)/$(MACH64)/.installed Makefile

test:   	$(NO_TESTS)

BUILD_PKG_DEPENDENCIES =	$(BUILD_TOOLS)

include $(WS_TOP)/make-rules/depend.mk
