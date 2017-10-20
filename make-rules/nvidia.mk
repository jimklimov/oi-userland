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
# Copyright 2017, Jim Klimov
# Copyright 2017 Andre Lupa
#

$(SOURCE_DIR)/.unpacked: download Makefile $(PATCHES)
	$(RM) -r $(SOURCE_DIR)
	$(SHELL) $(USERLAND_ARCHIVES)$(COMPONENT_ARCHIVE) -x
	$(TOUCH) $@

$(BUILD_32): $(SOURCE_DIR)/.prep
	$(RM) -r $(@D) ; $(MKDIR) $(@D)
	$(TOUCH) $@

NVDA_GRAPHICS  = $(SOURCE_DIR)/NVDAgraphics
NVDA_GRAPHICSR = $(SOURCE_DIR)/NVDAgraphicsr

# NOTE: It's not necessary to install gfx_private from the downloaded archive.
#
$(INSTALL_32): $(BUILD_32)
	[ -d $(PROTO_DIR)/kernel/drv/amd64 ] || mkdir -p $(PROTO_DIR)/kernel/drv/amd64
	for i in $$(grep "^1 f none" $(NVDA_GRAPHICSR)/pkgmap | cut -f4 -d' '); do \
	    cp $(NVDA_GRAPHICSR)/reloc/$$i $(PROTO_DIR)/$$i \
	 ; done
	[ -n "$(PROTO_DIR)" ] && rm -fr $(PROTO_DIR)/usr
	cp -a $(NVDA_GRAPHICS)/reloc $(PROTO_DIR)/usr
	$(TOUCH) $@

SVR4_MANIFEST_FILE = $(SAMPLE_MANIFEST_DIR)/svr4-manifest.p5m

$(SVR4_MANIFEST_FILE): $(SOURCE_DIR)/.unpacked
	[ -d $(SAMPLE_MANIFEST_DIR) ] || $(MKDIR) $(SAMPLE_MANIFEST_DIR)
	$(PKGSEND) generate $(NVDA_GRAPHICS) $(NVDA_GRAPHICSR) | \
	    $(PKGMOGRIFY) /dev/fd/0 $(GENERATE_TRANSFORMS) | \
	    sed -e '/^$$/d' -e '/^#.*$$/d' -e '/^dir .*$$/d' | \
	    $(PKGFMT) | \
	    cat $(METADATA_TEMPLATE) - >$@

sample-manifest: $(SVR4_MANIFEST_FILE) $(GENERATED).p5m

clean::
	if [ -d $(BUILD_DIR) ] ; then \
	  rm -rf $(BUILD_DIR) ; \
	fi
