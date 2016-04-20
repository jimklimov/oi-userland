#!/bin/sh

# Copyright (C) 2016 by Jim Klimov
# Inspect if "libGL.so.1" symlink was hijacked by VirtualBox installer

if ldd "/usr/openwin/lib/libGL.so.1" "/usr/openwin/lib/64/libGL.so.1" \
   2>/dev/null | \
   grep "VBox" \
; then
	echo "FATAL: Build this in a clean environment (needs basic system OpenGL libs)!"
	echo "HINT: Review definition of symlinks which VirtualBox installer tends to overwrite:"
	echo "      /usr/lib/mesa/libGL.so.1 and /usr/lib/mesa/${MACH64}/libGL.so.1  :"
	ls -dal /usr/lib/mesa/libGL.so.1 /usr/lib/mesa/${MACH64}/libGL.so.1
	exit 1
fi >&2

exit 0

