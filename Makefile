include $(TOPDIR)/rules.mk

PKG_NAME:=usb-modeswitch
PKG_VERSION:=2.2.0
PKG_RELEASE=1
PKG_MD5SUM:=f323fe700edd6ea404c40934ddf32b22

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_SOURCE_VERSION:=2.2.0
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.draisberghof.de/usb_modeswitch/
# http://www.draisberghof.de/usb_modeswitch/usb-modeswitch-2.2.0.tar.bz2
#CMAKE_INSTALL:=1

PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=

PKG_MAINTAINER:=Robin He <robin@focalcrest.org>

PKG_DATA_VERSION:=20140529
PKG_DATA_PATH:=usb-modeswitch-data-$(PKG_DATA_VERSION)
PKG_DATA_FILENAME:=$(PKG_DATA_PATH).tar.bz2
#http://www.draisberghof.de/usb_modeswitch/usb-modeswitch-data-20140529.tar.bz2
PKG_DATA_URL:=http://www.draisberghof.de/usb_modeswitch

include $(INCLUDE_DIR)/package.mk

define Download/data
  FILE:=$(PKG_DATA_FILENAME)
  URL:=$(PKG_DATA_URL)
  MD5SUM:=dff94177781298aaf0b3c2a3c3dea6b2
endef
$(eval $(call Download,data))

define Package/usb-modeswitch-official
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libusb-1.0
  TITLE:=Official usb_modeswitch switching utility
endef

define Build/Prepare
	$(Build/Prepare/Default)
	tar xvfj $(DL_DIR)/$(PKG_DATA_FILENAME) -C $(PKG_BUILD_DIR)
	tar xvfj $(DL_DIR)/$(PKG_SOURCE) -C $(BUILD_DIR)
	#mv $(PKG_BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION) $(PKG_BUILD_DIR)
#	rm -f \
#		$(PKG_BUILD_DIR)/$(PKG_DATA_PATH)/usb_modeswitch.d/05c6:1000:sVe=GT
endef

define Package/usb-modeswitch-official/install
	$(INSTALL_DIR) $(1)/etc/hotplug.d/usb $(1)/etc/init.d $(1)/usr/sbin $(1)/etc/usb_modeswitch.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/usb_modeswitch $(1)/usr/sbin/
	$(INSTALL_BIN) ./files/usb_modeswitch.sh $(1)/usr/sbin/
	$(INSTALL_DATA) ./files/40-usbmodeswitch $(1)/etc/hotplug.d/usb/40-usbmodeswitch
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/usb_modeswitch.conf $(1)/etc/
	$(INSTALL_DATA) ./files/usb_modeswitch.d/* $(1)/etc/usb_modeswitch.d/
	#$(CP) $(PKG_INSTALL_DIR)/usr/sbin/usb_modeswitch $(1)/sbin/
endef

$(eval $(call BuildPackage,usb-modeswitch-official))
