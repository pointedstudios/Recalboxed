################################################################################
#
# recalbox-romfs-cavestory
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --force --port --readonly --system cavestory --extension '.exe' --fullname 'Cave Story' --platform cavestory --theme cavestory 1:libretro:nxengine:BR2_PACKAGE_LIBRETRO_NXENGINE

# Name the 3 vars as the package requires
RECALBOX_ROMFS_CAVESTORY_SOURCE = 
RECALBOX_ROMFS_CAVESTORY_SITE = 
RECALBOX_ROMFS_CAVESTORY_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_CAVESTORY = cavestory
SYSTEM_XML_CAVESTORY = $(@D)/$(SYSTEM_NAME_CAVESTORY).xml
# System rom path
SOURCE_ROMDIR_CAVESTORY = $(RECALBOX_ROMFS_CAVESTORY_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_NXENGINE),)
define CONFIGURE_MAIN_CAVESTORY_START
	$(call RECALBOX_ROMFS_CALL_ADD_PORT,$(SYSTEM_XML_CAVESTORY),Cave Story,$(SYSTEM_NAME_CAVESTORY),.exe,cavestory,cavestory,1)
endef

ifneq ($(BR2_PACKAGE_LIBRETRO_NXENGINE),)
define CONFIGURE_CAVESTORY_LIBRETRO_START
	$(call RECALBOX_ROMFS_CALL_START_EMULATOR,$(SYSTEM_XML_CAVESTORY),libretro)
endef
ifeq ($(BR2_PACKAGE_LIBRETRO_NXENGINE),y)
define CONFIGURE_CAVESTORY_LIBRETRO_NXENGINE_DEF
	$(call RECALBOX_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_CAVESTORY),nxengine,1)
endef
endif

define CONFIGURE_CAVESTORY_LIBRETRO_END
	$(call RECALBOX_ROMFS_CALL_END_EMULATOR,$(SYSTEM_XML_CAVESTORY))
endef
endif



define CONFIGURE_MAIN_CAVESTORY_END
	$(call RECALBOX_ROMFS_CALL_END_PORT,$(SYSTEM_XML_CAVESTORY),$(SOURCE_ROMDIR_CAVESTORY),$(@D),cavestory)
endef
endif

define RECALBOX_ROMFS_CAVESTORY_CONFIGURE_CMDS
	$(CONFIGURE_MAIN_CAVESTORY_START)
	$(CONFIGURE_CAVESTORY_LIBRETRO_START)
	$(CONFIGURE_CAVESTORY_LIBRETRO_NXENGINE_DEF)
	$(CONFIGURE_CAVESTORY_LIBRETRO_END)
	$(CONFIGURE_MAIN_CAVESTORY_END)
endef

$(eval $(generic-package))
