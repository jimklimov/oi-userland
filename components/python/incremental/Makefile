#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#

#
# Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
#

BUILD_STYLE = setup.py
BUILD_BITS = NO_ARCH

include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		incremental
COMPONENT_VERSION=	17.5.0
COMPONENT_SUMMARY=	'Python project versioning library'
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH=	\
    sha256:8d34abfb46e0ba08e2b655fe4bdcd49025a2a5079063e5170b8919aae910669b
COMPONENT_ARCHIVE_URL=	$(call pypi_url)
COMPONENT_PROJECT_URL=	https://github.com/twisted/incremental
COMPONENT_CLASSIFICATION = Development/Python
COMPONENT_FMRI=	library/python/incremental
COMPONENT_LICENSE= MIT
COMPONENT_LICENSE_FILE = LICENSE

PYTHON_VERSIONS = 2.7 3.5 3.7 3.9

include $(WS_MAKE_RULES)/common.mk

COMPONENT_TEST_DIR =	$(SOURCE_DIR)/src/$(COMPONENT_NAME)/tests
COMPONENT_TEST_CMD =	$(PYTHON) -m pytest
COMPONENT_TEST_ARGS =	test_version.py

# testing dependencies
REQUIRED_PACKAGES += library/python/python-twisted

# Auto-generated dependencies
REQUIRED_PACKAGES += runtime/python-27
REQUIRED_PACKAGES += runtime/python-35
REQUIRED_PACKAGES += runtime/python-37
REQUIRED_PACKAGES += runtime/python-39
