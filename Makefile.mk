include $(TOPDIR)/rules.mk
# Name, version and release number
# The name and version of your package are used to define the variable to point to the build directory of your package: $(PKG_BUILD_DIR)
PKG_NAME:=example1
PKG_VERSION:=1.0.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_MAINTAINER:=Bilal Azhar <bilal.z@dplit.com>
PKG_LICENSE:=CC0-1.0

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk
# Package definition; instructs on how and where our package will appear in the overall configuration menu ('make menuconfig')
define Package/example1
	SECTION:=utils
	# Select package by default
	#DEFAULT:=y
	CATEGORY:=Utilities
	TITLE:=Some different dummy application.
	URL:=https://www.example.com
endef
# Package description; a more verbose description on what our package does
define Package/example1/description
	This is some dummy application.
endef
# Package preparation instructions; create the build directory and copy the source code. 
define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef
# Package install instructions; create a directory inside the package to hold our executable, and then copy the executable cmake will build into the folder
define Package/example1/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/example1 $(1)/usr/bin/ # Verify this path from past tested example
endef

$(eval $(call BuildPackage,example1))
