include $(TOPDIR)/rules.mk

PKG_NAME:=example1
PKG_VERSION:=1.0.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_MAINTAINER:=Bilal Azhar <bilal.z@dplit.com>
PKG_LICENSE:=CC0-1.0

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/example1
	SECTION:=utils
	# Select package by default
	#DEFAULT:=y
	CATEGORY:=Utilities
	TITLE:=Some dummy application.
	URL:=https://www.example.com
endef

define Package/example2/description
	This is some dummy application.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./poject/* $(PKG_BUILD_DIR)/
endef

define Package/example1/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/example1 $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DATA) $(TOOLCHAIN_DIR)/lib/libstdc++.so.6 $(1)/usr/lib
endef

$(eval $(call BuildPackage,example1))
