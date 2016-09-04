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
# Copyright 2016 by Jim Klimov
#
include ../../../make-rules/shared-macros.mk

# This one only delivers a file if other prereqs are present
# The network-ssh-askpass package is a dispatcher to depend on optional
# implementation packages, such as (initially) the network-ssh-askpass-zenity
COMPONENT_NAME=		ssh-askpass
COMPONENT_VERSION=	1.0

include $(WS_MAKE_RULES)/justmake.mk
include $(WS_MAKE_RULES)/ips.mk

# common targets
build:

install:

test:		$(NO_TESTS)

REQUIRED_PACKAGES += gnome/zenity
REQUIRED_PACKAGES += network/ssh
