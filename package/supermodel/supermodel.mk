################################################################################
#
# Supermodel
#
################################################################################

SUPERMODEL_VERSION = r833
SUPERMODEL_SITE = svn://svn.code.sf.net/p/model3emu/code/trunk
SUPERMODEL_SITE_METHOD = svn
SUPERMODEL_LICENSE = GPL2
SUPERMODEL_DEPENDENCIES = zlib libpng libogg libvorbis sdl2_net sdl2

define SUPERMODEL_BUILD_CMDS
	cp $(@D)/Makefiles/Makefile.UNIX $(@D)/Makefile
	$(SED) "s|OPT = -Ofast|OPT = -O3 -fno-strict-aliasing|g" $(@D)/Makefiles/Rules.inc
	$(SED) "s|-Ofast|-O3 -fno-strict-aliasing |g" $(@D)/Makefile
	$(SED) "s|CC = gcc|CC = $(TARGET_CC)|g" $(@D)/Makefile
	$(SED) "s|CXX = g++|CXX = $(TARGET_CXX)|g" $(@D)/Makefile
	$(SED) "s|LD = gcc|LD = $(TARGET_CC)|g" $(@D)/Makefile
	$(SED) "s|sdl2-config|$(STAGING_DIR)/usr/bin/sdl2-config|g" $(@D)/Makefile
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) -f Makefile \
	NET_BOARD=1 DEBUG=0 NEW_FRAME_TIMING=1 ENABLE_DEBUGGER=0
endef

define SUPERMODEL_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/bin/supermodel \
		$(TARGET_DIR)/usr/bin/supermodel
	$(INSTALL) -D -m 0644 $(@D)/Config/Games.xml \
		$(TARGET_DIR)/recalbox/share_init/system/configs/model3/Games.xml
	$(INSTALL) -D -m 0644 $(@D)/Config/Supermodel.ini \
		$(TARGET_DIR)/recalbox/share_init/system/configs/model3/Supermodel.ini
	mkdir -p $(TARGET_DIR)/recalbox/share_init/saves/model3/NVRAM
endef

define SUPERMODEL_LINE_ENDINGS_FIXUP
	# DOS2UNIX Supermodel.ini and Main.cpp - patch system does not support different line endings
	sed -i -E -e "s|\r$$||g" $(@D)/Src/OSD/SDL/Main.cpp
	sed -i -E -e "s|\r$$||g" $(@D)/Src/Inputs/Inputs.cpp
endef

SUPERMODEL_PRE_PATCH_HOOKS += SUPERMODEL_LINE_ENDINGS_FIXUP

$(eval $(generic-package))
