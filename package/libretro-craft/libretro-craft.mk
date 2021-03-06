################################################################################
#
# CRAFT
#
################################################################################

LIBRETRO_CRAFT_VERSION = 3f1d38299dccb74ad0726b1c743a0c34fde01e80
LIBRETRO_CRAFT_SITE = $(call github,libretro,Craft,$(LIBRETRO_CRAFT_VERSION))

ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
LIBRETRO_CRAFT_DEPENDENCIES += libgl
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
LIBRETRO_CRAFT_DEPENDENCIES += libgles
endif

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_RPI1),y)
LIBRETRO_CRAFT_PLATFORM=rpi1
else ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_RPI2),y)
LIBRETRO_CRAFT_PLATFORM=rpi2
else ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_RPI3),y)
LIBRETRO_CRAFT_PLATFORM=rpi3
else ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_RPI4),y)
LIBRETRO_CRAFT_PLATFORM=rpi4
else
LIBRETRO_CRAFT_PLATFORM=$(RETROARCH_LIBRETRO_PLATFORM)
endif

ifeq ($(BR2_arm),y)
LIBRETRO_CRAFT_OPTS += FORCE_GLES=1
endif

define LIBRETRO_CRAFT_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile.libretro
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile.libretro platform="$(LIBRETRO_CRAFT_PLATFORM)" $(LIBRETRO_CRAFT_OPTS)
endef

define LIBRETRO_CRAFT_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/craft_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/craft_libretro.so
endef

$(eval $(generic-package))
