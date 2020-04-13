################################################################################
#
# OPENBOR
#
################################################################################

OPENBOR_VERSION = c67563f91a470e9680536e664b5ff46dced7f8ab
OPENBOR_SITE = https://gitlab.com/Bkg2k/openbor
OPENBOR_SITE_METHOD = git
OPENBOR_DEPENDENCIES = sdl2 sdl2_gfx sdl2_mixer libpng libvpx

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_RPI3),y)
OPENBOR_PLATFORM_OPTS=
OPENBOR_BUILD_TARGET=BUILD_PANDORA
else ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_RPI2),y)
OPENBOR_PLATFORM_OPTS=
OPENBOR_BUILD_TARGET=BUILD_PANDORA
else ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_RPI1),y)
OPENBOR_PLATFORM_OPTS=
OPENBOR_BUILD_TARGET=BUILD_PANDORA
else ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_XU4),y)
OPENBOR_PLATFORM_OPTS=
OPENBOR_BUILD_TARGET=BUILD_PANDORA
else ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_C2),y)
OPENBOR_PLATFORM_OPTS=
OPENBOR_BUILD_TARGET=BUILD_PANDORA
else ifeq ($(BR2_i386),y)
OPENBOR_PLATFORM_OPTS=-m32
OPENBOR_BUILD_TARGET=BUILD_LINUX
else ifeq ($(BR2_x86_64),y)
OPENBOR_PLATFORM_OPTS=-m64
OPENBOR_BUILD_TARGET=BUILD_LINUX
else
OPENBOR_PLATFORM_OPTS=
OPENBOR_BUILD_TARGET=BUILD_LINUX
endif

define OPENBOR_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/engine/Makefile
	(cd $(@D)/engine && ./version.sh)
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO) $(OPENBOR_PLATFORM_OPTS)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO) $(OPENBOR_PLATFORM_OPTS)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/engine -f Makefile $(OPENBOR_BUILD_TARGET)=1 TARGET_GCC=$(TARGET_CXX) PNDDEV=$(STAGING_DIR)
endef

define OPENBOR_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/engine/OpenBOR \
		$(TARGET_DIR)/usr/bin/OpenBOR
endef

define OPENBOR_POST_EXTRACT_FIX_SDL2_PATH
	# SDL2 Path
	/bin/sed -i -E -e "s|\`pkg-config sdl2 --cflags\`|`$(STAGING_DIR)/usr/bin/sdl2-config --cflags`|g" $(@D)/engine/Makefile
	# Replace strip
	/bin/sed -i -E -e "s|\\$$\(PNDDEV\)/bin/arm-none-linux-gnueabi-strip|$(TARGET_STRIP)|g" $(@D)/engine/Makefile
	# Replace all "Saves" in a row
	/bin/sed -i -E -e "s|\"Saves\"|\"saves/openbor\"|g" $(@D)/engine/openbor.c
	/bin/sed -i -E -e "s|\"Saves\"|\"saves/openbor\"|g" $(@D)/engine/openborscript.c
endef

OPENBOR_POST_EXTRACT_HOOKS += OPENBOR_POST_EXTRACT_FIX_SDL2_PATH

ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
OPENBOR_DEPENDENCIES += libgl
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
OPENBOR_DEPENDENCIES += libgles
endif

$(eval $(generic-package))