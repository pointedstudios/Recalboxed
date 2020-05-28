################################################################################
#
# recalbox-romfs-dungeoncrawlstonesoup
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --force --port --system dungeoncrawlstonesoup --extension '.crawlrc' --fullname 'Dungeon Crawl Stone Soup' --platform dungeoncrawlstonesoup --theme dungeoncrawlstonesoup 1:libretro:stonesoup:BR2_PACKAGE_LIBRETRO_CRAWL

# Name the 3 vars as the package requires
RECALBOX_ROMFS_DUNGEONCRAWLSTONESOUP_SOURCE = 
RECALBOX_ROMFS_DUNGEONCRAWLSTONESOUP_SITE = 
RECALBOX_ROMFS_DUNGEONCRAWLSTONESOUP_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_DUNGEONCRAWLSTONESOUP = dungeoncrawlstonesoup
SYSTEM_XML_DUNGEONCRAWLSTONESOUP = $(@D)/$(SYSTEM_NAME_DUNGEONCRAWLSTONESOUP).xml
# System rom path
SOURCE_ROMDIR_DUNGEONCRAWLSTONESOUP = $(RECALBOX_ROMFS_DUNGEONCRAWLSTONESOUP_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_CRAWL),)
define CONFIGURE_MAIN_DUNGEONCRAWLSTONESOUP_START
	$(call RECALBOX_ROMFS_CALL_ADD_PORT,$(SYSTEM_XML_DUNGEONCRAWLSTONESOUP),Dungeon Crawl Stone Soup,$(SYSTEM_NAME_DUNGEONCRAWLSTONESOUP),.crawlrc,dungeoncrawlstonesoup,dungeoncrawlstonesoup)
endef

ifneq ($(BR2_PACKAGE_LIBRETRO_CRAWL),)
define CONFIGURE_DUNGEONCRAWLSTONESOUP_LIBRETRO_START
	$(call RECALBOX_ROMFS_CALL_START_EMULATOR,$(SYSTEM_XML_DUNGEONCRAWLSTONESOUP),libretro)
endef
ifeq ($(BR2_PACKAGE_LIBRETRO_CRAWL),y)
define CONFIGURE_DUNGEONCRAWLSTONESOUP_LIBRETRO_STONESOUP_DEF
	$(call RECALBOX_ROMFS_CALL_ADD_CORE,$(SYSTEM_XML_DUNGEONCRAWLSTONESOUP),stonesoup,1)
endef
endif

define CONFIGURE_DUNGEONCRAWLSTONESOUP_LIBRETRO_END
	$(call RECALBOX_ROMFS_CALL_END_EMULATOR,$(SYSTEM_XML_DUNGEONCRAWLSTONESOUP))
endef
endif



define CONFIGURE_MAIN_DUNGEONCRAWLSTONESOUP_END
	$(call RECALBOX_ROMFS_CALL_END_PORT,$(SYSTEM_XML_DUNGEONCRAWLSTONESOUP),$(SOURCE_ROMDIR_DUNGEONCRAWLSTONESOUP),$(@D),dungeoncrawlstonesoup)
endef
endif

define RECALBOX_ROMFS_DUNGEONCRAWLSTONESOUP_CONFIGURE_CMDS
	$(CONFIGURE_MAIN_DUNGEONCRAWLSTONESOUP_START)
	$(CONFIGURE_DUNGEONCRAWLSTONESOUP_LIBRETRO_START)
	$(CONFIGURE_DUNGEONCRAWLSTONESOUP_LIBRETRO_STONESOUP_DEF)
	$(CONFIGURE_DUNGEONCRAWLSTONESOUP_LIBRETRO_END)
	$(CONFIGURE_MAIN_DUNGEONCRAWLSTONESOUP_END)
endef

$(eval $(generic-package))