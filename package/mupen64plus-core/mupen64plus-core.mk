################################################################################
#
# mupen64plus core
#
################################################################################

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_ODROIDGO2),y)
# Commit of 29/10/2020
MUPEN64PLUS_CORE_VERSION = b50ca2e04b4c8dc3820f2529135819d25bba6f3b
MUPEN64PLUS_CORE_SITE = $(call github,OtherCrashOverride,mupen64plus-core-go2,$(MUPEN64PLUS_CORE_VERSION))
else
# Commit of 29/10/2020
MUPEN64PLUS_CORE_VERSION = 7b73d2db689b805708b99d202a06c5925e9a0980
MUPEN64PLUS_CORE_SITE = $(call github,mupen64plus,mupen64plus-core,$(MUPEN64PLUS_CORE_VERSION))
endif
MUPEN64PLUS_CORE_LICENSE = GPLv2+
MUPEN64PLUS_CORE_DEPENDENCIES = sdl2 alsa-lib libpng freetype host-nasm host-binutils
MUPEN64PLUS_CORE_INSTALL_STAGING = YES

MUPEN64PLUS_CORE_GL_CFLAGS = -I$(STAGING_DIR)/usr/include -L$(STAGING_DIR)/usr/lib

ifeq ($(BR2_PACKAGE_XORG7),y)
MUPEN64PLUS_CORE_GL_LDLIBS = -lGL
else
MUPEN64PLUS_CORE_GL_LDLIBS = -lGLESv2 -lEGL
MUPEN64PLUS_CORE_PARAMS += USE_GLES=1 NEW_DYNAREC=1
endif

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
MUPEN64PLUS_CORE_DEPENDENCIES += rpi-userland
MUPEN64PLUS_CORE_GL_LDLIBS += -lbcm_host
MUPEN64PLUS_CORE_PARAMS += VC=1
endif

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_RPI4),y)
MUPEN64PLUS_CORE_DEPENDENCIES += mesa3d
endif

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_ODROIDXU4),y)
MUPEN64PLUS_CORE_DEPENDENCIES += mali-t62x
endif

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_ODROIDGO2),y)
MUPEN64PLUS_CORE_DEPENDENCIES += rockchip-mali libdrm
endif

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_X86)$(BR2_PACKAGE_RECALBOX_TARGET_X86_64),y)
MUPEN64PLUS_CORE_DEPENDENCIES += mesa3d
endif

ifeq ($(BR2_arm),y)
MUPEN64PLUS_CORE_HOST_CPU = armv7
endif

ifeq ($(BR2_aarch64),y)
MUPEN64PLUS_CORE_HOST_CPU = aarch64
MUPEN64PLUS_CORE_PARAMS += BITS=64
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
MUPEN64PLUS_CORE_PARAMS += NEON=1
endif

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_X86),y)
MUPEN64PLUS_CORE_HOST_CPU = i586
endif

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_X86_64),y)
MUPEN64PLUS_CORE_HOST_CPU = x86_64
endif

define MUPEN64PLUS_CORE_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/projects/unix/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" LD="$(TARGET_LD)" RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" \
		    CROSS_COMPILE="$(STAGING_DIR)/usr/bin/" AS="$(HOST_DIR)/bin/nasm" STRINGS="$(STAGING_DIR)/../bin/strings" \
			PREFIX="$(STAGING_DIR)/usr" \
			SHAREDIR="/recalbox/share/system/configs/mupen64/" \
			PKG_CONFIG="$(HOST_DIR)/usr/bin/pkg-config" \
			HOST_CPU="$(MUPEN64PLUS_CORE_HOST_CPU)" \
			-C $(@D)/projects/unix all $(MUPEN64PLUS_CORE_PARAMS) OPTFLAGS="$(TARGET_CXXFLAGS)"
endef

define MUPEN64PLUS_CORE_INSTALL_STAGING_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/projects/unix/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" LD="$(TARGET_LD)" RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" CROSS_COMPILE="$(STAGING_DIR)/usr/bin/" \
			PREFIX="$(STAGING_DIR)/usr" \
			SHAREDIR="$(TARGET_DIR)/recalbox/share_init/system/configs/mupen64/" \
			PKG_CONFIG="$(HOST_DIR)/usr/bin/pkg-config" \
			HOST_CPU="$(MUPEN64PLUS_CORE_HOST_CPU)" \
			INSTALL="/usr/bin/install" \
			INSTALL_STRIP_FLAG="" \
			-C $(@D)/projects/unix all $(MUPEN64PLUS_CORE_PARAMS) OPTFLAGS="$(TARGET_CXXFLAGS)" install
endef

define MUPEN64PLUS_CORE_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0644 $(@D)/projects/unix/libmupen64plus.so.2.0.0 $(TARGET_DIR)/usr/lib
	mkdir -p $(TARGET_DIR)/recalbox/share_init/system/configs/mupen64/hires_texture
endef

define MUPEN64PLUS_CORE_CROSS_FIXUP
	$(SED) 's|/opt/vc/include|$(STAGING_DIR)/usr/include|g' $(@D)/projects/unix/Makefile
	$(SED) 's|/opt/vc/lib|$(STAGING_DIR)/usr/lib|g' $(@D)/projects/unix/Makefile
	$(SED) 's|-I/usr/include|-I$(STAGING_DIR)/usr/include|g' $(@D)/projects/unix/Makefile
endef

MUPEN64PLUS_CORE_PRE_CONFIGURE_HOOKS += MUPEN64PLUS_CORE_CROSS_FIXUP

$(eval $(generic-package))
