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
# Copyright 2014 Alexander Pyhalov.  All rights reserved.
# Copyright 2019 Jason Martin
#

BUILD_BITS=64_and_32
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME= libwebp
COMPONENT_VERSION= 1.2.0
COMPONENT_FMRI= library/libwebp
COMPONENT_SUMMARY= WebP image format library
COMPONENT_CLASSIFICATION= System/Libraries
COMPONENT_SRC= $(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE= $(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH= sha256:2fc8bbde9f97f2ab403c0224fb9ca62b2e6852cbc519e91ceaa7c153ffd88a0c
COMPONENT_ARCHIVE_URL=	https://storage.googleapis.com/downloads.webmproject.org/releases/webp/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://developers.google.com/speed/webp/
COMPONENT_LICENSE= BSD

include $(WS_MAKE_RULES)/common.mk

PATH=$(PATH.gnu)

COMPONENT_PREP_ACTION= ( cd $(@D); sh autogen.sh; )

# build with the distribution preferred libjpeg implementation
CFLAGS   += $(JPEG_CPPFLAGS) $(JPEG_CFLAGS)
CXXFLAGS += $(JPEG_CPPFLAGS) $(JPEG_CXXFLAGS)
LDFLAGS  += $(JPEG_LDFLAGS)

CONFIGURE_OPTIONS += --disable-static
CONFIGURE_OPTIONS += --sysconfdir=/etc
CONFIGURE_OPTIONS += --enable-libwebpmux
CONFIGURE_OPTIONS += --enable-libwebpdemux
CONFIGURE_OPTIONS += --enable-libwebpdecoder
CONFIGURE_OPTIONS += --enable-libwebpextras
CONFIGURE_OPTIONS += --enable-swap-16bit-csp

# Auto-generated dependencies
REQUIRED_PACKAGES += image/library/libjpeg8-turbo
REQUIRED_PACKAGES += image/library/libpng16
REQUIRED_PACKAGES += image/library/libtiff
REQUIRED_PACKAGES += library/giflib
REQUIRED_PACKAGES += system/library
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += x11/library/freeglut
