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
# Copyright 2016 Jim Klimov. All rights reserved.
#

include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		util-linux
COMPONENT_NAME_GNUFDISK=	gnufdisk
COMPONENT_VERSION=	2.27.1
COMPONENT_LICENSE=	GPLv2
COMPONENT_PROJECT_URL=	http://freecode.com/projects/util-linux
COMPONENT_SUMMARY=	The util-linux project includes a number of standard Linux programs, and is a new home for the GNU fdisk - a powerful partitioning tool
COMPONENT_SUMMARY_GNUFDISK=	GNU fdisk - a powerful partitioning tool
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_URL=	http://ftp.kernel.org/pub/linux/utils/util-linux/v2.27/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH=	\
    sha256:0a818fcdede99aec43ffe6ca5b5388bff80d162f2f7bd4541dca94fecb87a290

include ../../make-rules/prep.mk
include ../../make-rules/configure.mk
include ../../make-rules/ips.mk

# Set PATH to find /usr/perl5/bin/pod2man, so that the man pages can be
# automatically generated
COMPONENT_BUILD_ENV +=	PATH="/usr/bin:/usr/gnu/bin:/usr/perl5/bin"
PKG_OPTIONS += \
    -D COMPONENT_NAME_GNUFDISK="$(COMPONENT_NAME_GNUFDISK)" \
    -D COMPONENT_SUMMARY_GNUFDISK="$(COMPONENT_SUMMARY_GNUFDISK)"

CONFIGURE_OPTIONS  +=	--enable-static
CONFIGURE_OPTIONS  +=	--enable-shared
CONFIGURE_OPTIONS  +=	--sysconfdir=/etc

# Custom files from BSD
CFLAGS +=		-I $(COMPONENT_DIR)/files/include

# SIOCGIFHWADDR causes libuuid to use structure members illumos does not have
COMPONENT_POST_CONFIGURE_ACTION = \
    (cd $(@D) && { \
        echo '\#ifdef SIOCGIFHWADDR'; echo '\#undef SIOCGIFHWADDR' ; echo '\#endif'; \
    } >> config.h )

# Snatched from Firefox component
COMPONENT_PRE_CONFIGURE_ACTION = \
    (cp $(COMPONENT_DIR)/files/gld-wrapper $(BUILD_DIR); chmod +x $(BUILD_DIR)/gld-wrapper )
ENV +=  GLD_WRAPPER=$(BUILD_DIR)/gld-wrapper
LD := $(BUILD_DIR)/gld-wrapper

#COMPONENT_PRE_CONFIGURE_ACTION = \
#    (cp -r $(COMPONENT_DIR)/files/include $(SOURCE_DIR))
#    (cp -r $(COMPONENT_DIR)/files/include $(@D))

# The set of options sufficient to get just the fdisk family of tools/libs:
CONFIGURE_OPTIONS_GNUFDISK  = --disable-nls --without-user --without-python \
    --disable-all-programs --enable-static-programs="blkid fdisk sfdisk" \
    --enable-libuuid --enable-libblkid --enable-libfdisk \
    --with-slang --with-ncurses --with-readline \
    --without-systemd --without-capng --without-termcap

CONFIGURE_OPTIONS  +=	$(CONFIGURE_OPTIONS_GNUFDISK)

build:		$(BUILD_32_and_64)

install:	$(INSTALL_32_and_64)

test:		$(NO_TESTS)

include ../../make-rules/depend.mk
