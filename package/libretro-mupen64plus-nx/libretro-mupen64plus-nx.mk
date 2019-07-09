################################################################################
#
# MUPEN64PLUS_NX
#
################################################################################

LIBRETRO_MUPEN64PLUS_NX_VERSION = 16d96924d8a31483bfd0b2d1bc39dc6e319d4352
LIBRETRO_MUPEN64PLUS_NX_SITE = $(call github,libretro,mupen64plus-libretro-nx,$(LIBRETRO_MUPEN64PLUS_NX_VERSION))
LIBRETRO_MUPEN64PLUS_NX_LICENSE = GPLv3

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
LIBRETRO_MUPEN64PLUS_NX_DEPENDENCIES += rpi-userland
endif

ifeq ($(BR2_PACKAGE_MESA3D),y)
LIBRETRO_MUPEN64PLUS_NX_DEPENDENCIES += mesa3d
endif

ifeq ($(BR2_i386)$(BR2_x86_64),y)
LIBRETRO_MUPEN64PLUS_NX_DEPENDENCIES += host-nasm
endif

LIBRETRO_MUPEN64PLUS_NX_SUPP_OPT=

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_RPI3),y)
LIBRETRO_MUPEN64PLUS_NX_SUPP_OPT=FORCE_GLES=1 ARCH=arm
LIBRETRO_MUPEN64PLUS_NX_PLATFORM=rpi3
else ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_RPI2),y)
LIBRETRO_MUPEN64PLUS_NX_SUPP_OPT=FORCE_GLES=1 ARCH=arm
LIBRETRO_MUPEN64PLUS_NX_PLATFORM=rpi2
else ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_XU4),y)
LIBRETRO_MUPEN64PLUS_NX_SUPP_OPT=FORCE_GLES=1 ARCH=aarch64
LIBRETRO_MUPEN64PLUS_NX_PLATFORM=odroid
else ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_C2),y)
LIBRETRO_MUPEN64PLUS_NX_SUPP_OPT=FORCE_GLES=1 ARCH=aarch64
LIBRETRO_MUPEN64PLUS_NX_PLATFORM=unix
else ifeq ($(BR2_i386),y)
LIBRETRO_MUPEN64PLUS_NX_SUPP_OPT=ARCH=i686
LIBRETRO_MUPEN64PLUS_NX_PLATFORM=unix
else ifeq ($(BR2_x86_64),y)
LIBRETRO_MUPEN64PLUS_NX_SUPP_OPT="ARCH=i686 x86_64"
LIBRETRO_MUPEN64PLUS_NX_PLATFORM=unix
else
LIBRETRO_MUPEN64PLUS_NX_PLATFORM=$(LIBRETRO_PLATFORM)
endif

define LIBRETRO_MUPEN64PLUS_NX_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) NASM="$(HOST_DIR)/bin/nasm)" CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_MUPEN64PLUS_NX_PLATFORM)" $(LIBRETRO_MUPEN64PLUS_NX_SUPP_OPT)
endef

define LIBRETRO_MUPEN64PLUS_NX_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/mupen64plus_next_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/mupen64plus_next_libretro.so
endef

define MUPEN64PLUS_NX_CROSS_FIXUP
	$(SED) 's|/opt/vc/include|$(STAGING_DIR)/usr/include|g' $(@D)/Makefile
	$(SED) 's|/opt/vc/lib|$(STAGING_DIR)/usr/lib|g' $(@D)/Makefile
endef

LIBRETRO_MUPEN64PLUS_NX_PRE_CONFIGURE_HOOKS += MUPEN64PLUS_NX_CROSS_FIXUP

$(eval $(generic-package))
