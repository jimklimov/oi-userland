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
# Copyright 2012, Andrzej Szeszo
#

include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		driver-graphics-nvidia
COMPONENT_VERSION=	340.104
IPS_COMPONENT_VERSION=	0.$(COMPONENT_VERSION)
COMPONENT_SRC=		NVIDIA-Solaris-x86-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).run
COMPONENT_ARCHIVE_HASH= \
	sha256:1fb837b7047e6b08df2a5eb973ae70ea07e5194570b24b966d3f97572cb6a450
COMPONENT_ARCHIVE_URL=	http://us.download.nvidia.com/solaris/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	http://www.nvidia.com/object/solaris-display-archive.html

include $(WS_MAKE_RULES)/prep.mk
include $(WS_MAKE_RULES)/ips.mk
include $(WS_MAKE_RULES)/nvidia.mk

build: $(BUILD_32)

install: $(INSTALL_32)

REQUIRED_PACKAGES += SUNWcs
REQUIRED_PACKAGES += library/desktop/atk
REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/gtk2
REQUIRED_PACKAGES += library/desktop/pango
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += system/library
REQUIRED_PACKAGES += system/library/gcc-4-runtime
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += x11/compatibility/links-xorg
REQUIRED_PACKAGES += x11/library/libx11
REQUIRED_PACKAGES += x11/library/libxext
