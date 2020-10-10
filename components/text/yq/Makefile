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
# Copyright 2020, Jim Klimov
#

PREFERRED_BITS=64

include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=         yq
COMPONENT_VERSION=      3.4.0
COMPONENT_SUMMARY=      yq - a lightweight and portable command-line YAML processor, the sed of YAML files
COMPONENT_PROJECT_URL=	https://github.com/mikefarah/yq
COMPONENT_FMRI=         text/jq
COMPONENT_CLASSIFICATION=Applications/System Utilities
COMPONENT_SRC=          $(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=      $(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH= \
  sha256:76b96cd2ba503eef396d8773d874b4fdc56fc3aff3c61b0808afadff2a6daae7
# https://github.com/mikefarah/yq/archive/3.4.0.tar.gz
COMPONENT_ARCHIVE_URL=	\
  $(COMPONENT_PROJECT_URL)/archive/$(COMPONENT_VERSION).tar.gz
COMPONENT_LICENSE=      MIT

include $(WS_MAKE_RULES)/prep.mk
include $(WS_MAKE_RULES)/justmake.mk
include $(WS_MAKE_RULES)/ips.mk

# Magic for building with golang largely borrowed from mongodb-4.0 recipe
#GMAKE=scons
CORES=$(shell psrinfo -v|grep '^Status of'|tail -1|awk '{print $$5}')
GOROOT=$(shell go env | grep GOROOT | awk -F= '{ print $$2 }' | tr -d '"')
export GOROOT
GOOS=illumos
export GOOS

ENV = /usr/bin/env -i

COMPONENT_BUILD_ARGS += TARGET_ARCH=x86_64
COMPONENT_BUILD_ARGS += CXXFLAGS="$(CXXFLAGS)"
COMPONENT_BUILD_ARGS += CC="$(CC)"
COMPONENT_BUILD_ARGS += CXX="$(CXX)"
COMPONENT_BUILD_ARGS += CFLAGS="$(CFLAGS)"
COMPONENT_BUILD_ARGS += LIBPATH=/usr/lib/$(MACH64)
COMPONENT_BUILD_ARGS += LINKFLAGS="$(LDFLAGS)"
COMPONENT_BUILD_ARGS += AR=/usr/bin/gar
COMPONENT_BUILD_ARGS += DOCKRUN=

#COMPONENT_BUILD_ARGS += --prefix=$(PROTO_DIR)/usr
#COMPONENT_BUILD_ARGS += --use-system-zlib
#COMPONENT_BUILD_ARGS += --disable-ggdb
# Fixes gcc 7 build
#COMPONENT_BUILD_ARGS += --disable-warnings-as-errors

#COMPONENT_BUILD_ARGS += -j $(CORES)

# https://github.com/mikefarah/yq/blob/master/CONTRIBUTING.md
# "local" must run first to avoid docker
COMPONENT_PREP_ACTION = ( cd $(@D) && ./scripts/devtools.sh && $(MAKE) local )

COMPONENT_BUILD_ARGS += -j1
COMPONENT_BUILD_TARGETS= local vendor build
COMPONENT_INSTALL_ARGS = install

build:   $(BUILD_64)

install: $(INSTALL_64)

#test:    $(TEST_64)

# Auto-generated dependencies
REQUIRED_PACKAGES += system/library
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += developer/gcc-6
REQUIRED_PACKAGES += developer/golang
