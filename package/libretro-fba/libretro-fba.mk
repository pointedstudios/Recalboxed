################################################################################
#
# FBA
#
################################################################################
LIBRETRO_FBA_VERSION = 4590677b302d658550bcc50582bec2664b7f84dc
LIBRETRO_FBA_SITE = $(call github,libretro,fbalpha,$(LIBRETRO_FBA_VERSION))

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
	LIBRETRO_FBA_NEON += "HAVE_NEON=1"
else
	LIBRETRO_FBA_NEON += "HAVE_NEON=0"
endif

define LIBRETRO_FBA_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f makefile.libretro platform="$(LIBRETRO_BOARD)" $(LIBRETRO_FBA_NEON)
endef

define LIBRETRO_FBA_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/fbalpha_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/fba_libretro.so
endef

$(eval $(generic-package))
