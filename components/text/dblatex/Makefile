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
# Copyright 2021 Jim Klimov
#

BUILD_STYLE=setup.py
BUILD_BITS=NO_ARCH

include ../../../make-rules/shared-macros.mk

COMPONENT_NAME= 	dblatex
COMPONENT_VERSION= 	0.3.12
COMPONENT_SUMMARY= 	DocBook to LaTeX Publishing
### Note "3" in dblatex3 of the source archive
### https://sourceforge.net/projects/dblatex/files/dblatex/dblatex-0.3.12/dblatex3-0.3.12.tar.bz2/download
COMPONENT_SRC= 		$(COMPONENT_NAME)3-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE= 	$(COMPONENT_SRC).tar.bz2
COMPONENT_ARCHIVE_HASH=	sha256:16e82786272ed1806a079d37914d7ba7a594db792dc4cc34c1c3737dbd4da079
COMPONENT_ARCHIVE_URL=	https://sourceforge.net/projects/$(COMPONENT_NAME)/files/$(COMPONENT_NAME)/$(COMPONENT_NAME)-$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)/download
COMPONENT_PROJECT_URL=	https://sourceforge.net/projects/$(COMPONENT_NAME)/
COMPONENT_LICENSE=	GPLv2

TEST_TARGET= $(TEST_64)

GCC_VERSION=		10
PYTHON_VERSION=		3.9
PYTHON_VERSIONS=	3.9

include $(WS_MAKE_RULES)/common.mk

PATH=$(PATH.gnu)

# Assumes GNU msgfmt is first in PATH
PYTHON_ENV += PATH="$(GCC_ROOT)/bin:$(PATH.gnu)"

COMPONENT_INSTALL_ARGS = --root $(PROTO_DIR) --force --prefix=/usr --install-lib=$(PYTHON_LIB)

# dblatex has no configure however it honors DESTDIR which is necessary so
# we don't try to install into roots /usr but rather our proto areas usr
#COMPONENT_INSTALL_ARGS +=	DESTDIR=$(PROTO_DIR)

# common targets
#build:		$(BUILD_32)

#install:	$(INSTALL_32)

test:		$(NO_TESTS)

# Manually added dependencies:
#REQUIRED_PACKAGES += image/graphviz
#REQUIRED_PACKAGES += library/libxml2
#REQUIRED_PACKAGES += library/libxslt
#REQUIRED_PACKAGES += library/python/pygments
#REQUIRED_PACKAGES += web/browser/w3m

### Requires "latex" and maybe other components as listed below;
### not present in oi-userland but available in SFE localhostoih:
# $ gmake sample-manifest
#...
#running install
#+checking XSLT xsltconf... yes
#+checking XSLT xsltproc... yes
#+checking XSLT saxon... no (missing saxon)
#warning: XSLT not found: saxon
#+checking convert... yes
#+checking epstopdf... no
#+checking fig2dev... no
#warning: not found: epstopdf, fig2dev
#+checking latex... no
#+checking makeindex... no
#+checking pdflatex... no
#+checking kpsewhich... no
#Error: not found: latex, makeindex, pdflatex, kpsewhich

# Auto-generated dependencies
REQUIRED_PACKAGES += runtime/python-39
