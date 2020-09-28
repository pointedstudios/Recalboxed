################################################################################
#
# kodi youtube plugin
#
################################################################################

KODI_PLUGIN_VIDEO_YOUTUBE_VERSION = 6.8.2
KODI_PLUGIN_VIDEO_YOUTUBE_SOURCE = plugin.video.youtube-$(KODI_PLUGIN_VIDEO_YOUTUBE_VERSION).zip
KODI_PLUGIN_VIDEO_YOUTUBE_SITE = https://github.com/jdf76/plugin.video.youtube/releases/download/$(KODI_PLUGIN_VIDEO_YOUTUBE_VERSION)
KODI_PLUGIN_VIDEO_YOUTUBE_PLUGINNAME=plugin.video.youtube

KODI_PLUGIN_VIDEO_YOUTUBE_TARGET_DIR=$(TARGET_DIR)/usr/share/kodi/addons

define KODI_PLUGIN_VIDEO_YOUTUBE_EXTRACT_CMDS
	@unzip -q -o $(DL_DIR)/kodi-plugin-video-youtube/$(KODI_PLUGIN_VIDEO_YOUTUBE_SOURCE) -d $(@D)
endef

define KODI_PLUGIN_VIDEO_YOUTUBE_INSTALL_TARGET_CMDS
	@mkdir -p $(KODI_PLUGIN_VIDEO_YOUTUBE_TARGET_DIR)
	@cp -r $(@D)/$(KODI_PLUGIN_VIDEO_YOUTUBE_PLUGINNAME) $(KODI_PLUGIN_VIDEO_YOUTUBE_TARGET_DIR)
	$(INSTALL) -D -m 0644 $(KODI_PLUGIN_VIDEO_YOUTUBE_PKGDIR)/api_keys.json $(TARGET_DIR)/recalbox/share_init/system/.kodi/userdata/addon_data/plugin.video.youtube/api_keys.json
endef

$(eval $(generic-package))
