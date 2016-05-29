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

include ../../../../make-rules/shared-macros.mk

COMPONENT_NAME=		libwebm
COMPONENT_VERSION=	1.0.0.27
COMPONENT_SUMMARY=	The WebM File Parser library
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tar.gz
COMPONENT_ARCHIVE_HASH= \
	sha256:1332f43742aeae215fd8df1be6e363e753b17abb37447190e789299fe3edec77
COMPONENT_ARCHIVE_URL= \
	https://github.com/webmproject/$(COMPONENT_NAME)/archive/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	http://www.webmproject.org/
COMPONENT_LICENSE=	BSD
COMPONENT_LICENSE_FILE=	LICENSE.TXT
COMPONENT_CLASSIFICATION=	System/Multimedia Libraries
COMPONENT_FMRI=	library/video/$(COMPONENT_NAME)

include $(WS_MAKE_RULES)/prep.mk
include $(WS_MAKE_RULES)/cmake.mk
include $(WS_MAKE_RULES)/ips.mk

PATH.32=/usr/gnu/bin:/usr/bin
PATH.64=/usr/gnu/bin/$(MACH64):/usr/gnu/bin:/usr/bin/$(MACH64):/usr/bin
PATH=$(PATH.$(BITS))

TARGET.32 = x86-solaris-gcc
TARGET.64 = x86_64-solaris-gcc

CXXFLAGS += -std=gnu++11

build: $(BUILD_32_and_64)

install: $(INSTALL_32_and_64)

BUILT_LIBS = libwebm.so
BUILT_BINS = sample sample_muxer vttdemux webm2pes
ELFEDIT_32 = \
		for F in $(BUILT_LIBS) $(BUILT_BINS) ; do \
			/usr/bin/elfedit -e "dyn:rpath ''" $$F && \
			/usr/bin/elfedit -e "dyn:runpath ''" $$F && \
			/usr/bin/elfedit -e 'dyn:value -s  RPATH '"$(USRLIBDIR)" $$F && \
			/usr/bin/elfedit -e 'dyn:value -s  RUNPATH '"$(USRLIBDIR)" $$F ; \
		done

ELFEDIT_64 = \
		for F in $(BUILT_LIBS) $(BUILT_BINS) ; do \
			/usr/bin/elfedit -e "dyn:rpath ''" $$F && \
			/usr/bin/elfedit -e "dyn:runpath ''" $$F && \
			/usr/bin/elfedit -e 'dyn:value -s  RPATH '"$(USRLIBDIR64)" $$F && \
			/usr/bin/elfedit -e 'dyn:value -s  RUNPATH '"$(USRLIBDIR64)" $$F ; \
		done

$(BUILD_DIR_32)/.installed: $(BUILD_DIR_32)/.built
	$(MKDIR) $(PROTOUSRBINDIR) $(PROTOUSRLIBDIR)
	cd $(BUILD_DIR_32) && $(ELFEDIT_32) && \
		$(CP) $(BUILT_LIBS) $(PROTOUSRLIBDIR) && \
		$(CP) $(BUILT_BINS) $(PROTOUSRBINDIR)
	$(TOUCH) $@

$(BUILD_DIR_64)/.installed: $(BUILD_DIR_64)/.built
	$(MKDIR) $(PROTOUSRBINDIR64) $(PROTOUSRLIBDIR64)
	cd $(BUILD_DIR_64) && $(ELFEDIT_64) && \
		$(CP) $(BUILT_LIBS) $(PROTOUSRLIBDIR64) && \
		$(CP) $(BUILT_BINS) $(PROTOUSRBINDIR64)
	$(TOUCH) $@

REQUIRED_PACKAGES += system/library
REQUIRED_PACKAGES += system/library/g++-4-runtime
REQUIRED_PACKAGES += system/library/gcc-4-runtime
