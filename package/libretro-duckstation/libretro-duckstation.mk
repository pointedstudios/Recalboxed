################################################################################
#
# DUCKSTATION
#
################################################################################

LIBRETRO_DUCKSTATION_VERSION = 82ffb1bc81f6d3e637b65762a6e0678e3a5e5ec1
LIBRETRO_DUCKSTATION_SITE = git://github.com/stenzek/duckstation.git
LIBRETRO_DUCKSTATION_GIT_SUBMODULES=y
LIBRETRO_DUCKSTATION_LICENSE = GPLv3

LIBRETRO_DUCKSTATION_CONF_OPTS=-DCMAKE_BUILD_TYPE=Release -DBUILD_LIBRETRO_CORE=ON -DBUILD_SHARED_LIBS=FALSE

define LIBRETRO_DUCKSTATION_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/duckstation_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/duckstation_libretro.so
endef

LIBRETRO_DUCKSTATION_CONF_OPTS += -DCMAKE_C_ARCHIVE_CREATE="<CMAKE_AR> qcs <TARGET> <LINK_FLAGS> <OBJECTS>"
LIBRETRO_DUCKSTATION_CONF_OPTS += -DCMAKE_C_ARCHIVE_FINISH=true
LIBRETRO_DUCKSTATION_CONF_OPTS += -DCMAKE_CXX_ARCHIVE_CREATE="<CMAKE_AR> qcs <TARGET> <LINK_FLAGS> <OBJECTS>"
LIBRETRO_DUCKSTATION_CONF_OPTS += -DCMAKE_CXX_ARCHIVE_FINISH=true
LIBRETRO_DUCKSTATION_CONF_OPTS += -DCMAKE_AR="$(TARGET_CC)-ar"
LIBRETRO_DUCKSTATION_CONF_OPTS += -DCMAKE_C_COMPILER="$(TARGET_CC)"
LIBRETRO_DUCKSTATION_CONF_OPTS += -DCMAKE_CXX_COMPILER="$(TARGET_CXX)"
LIBRETRO_DUCKSTATION_CONF_OPTS += -DCMAKE_LINKER="$(TARGET_LD)"
LIBRETRO_DUCKSTATION_CONF_OPTS += -DCMAKE_C_FLAGS="$(COMPILER_COMMONS_CFLAGS_SO)"
LIBRETRO_DUCKSTATION_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(COMPILER_COMMONS_CXXFLAGS_SO)"
LIBRETRO_DUCKSTATION_CONF_OPTS += -DCMAKE_LINKER_EXE_FLAGS="$(COMPILER_COMMONS_LDFLAGS_SO)"

$(eval $(cmake-package))
