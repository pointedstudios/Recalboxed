################################################################################
#
# kodi addon signals
#
################################################################################

KODI_PLUGIN_SCRIPT_ADDON_SIGNALS_VERSION = 904df4aabbf2edcd266d312e9e6ac9e03874d770
KODI_PLUGIN_SCRIPT_ADDON_SIGNALS_SOURCE = kodi-plugin-script-addon-signals-$(KODI_PLUGIN_SCRIPT_ADDON_SIGNALS_VERSION).tar.gz
KODI_PLUGIN_SCRIPT_ADDON_SIGNALS_SITE = https://github.com/ruuk/script.module.addon.signals.git
KODI_PLUGIN_SCRIPT_ADDON_SIGNALS_SITE_METHOD = git
KODI_PLUGIN_SCRIPT_ADDON_SIGNALS_PLUGIN_NAME = script.module.addon.signals

KODI_PLUGIN_SCRIPT_ADDON_SIGNALS_TARGET_DIR=$(TARGET_DIR)/usr/share/kodi/addons

define KODI_PLUGIN_SCRIPT_ADDON_SIGNALS_INSTALL_TARGET_CMDS
	@mkdir -p $(KODI_PLUGIN_SCRIPT_ADDON_SIGNALS_TARGET_DIR)/$(KODI_PLUGIN_SCRIPT_ADDON_SIGNALS_PLUGIN_NAME)
	@cp -r $(@D)/* $(KODI_PLUGIN_SCRIPT_ADDON_SIGNALS_TARGET_DIR)/$(KODI_PLUGIN_SCRIPT_ADDON_SIGNALS_PLUGIN_NAME)/
endef

$(eval $(generic-package))
