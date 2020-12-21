TARGET = iphone:clang:11.2:9.0
ARCHS = arm64 arm64e
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ScrolleX
ScrolleX_FILES = $(wildcard *.m)
ScrolleX_INSTALL_PATH = /Library/PreferenceBundles
ScrolleX_FRAMEWORKS = UIKit
ScrolleX_PRIVATE_FRAMEWORKS = Preferences
ScrolleX_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
ScrolleX_LDFLAGS += -lCSColorPicker
ScrolleX_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ScrolleX.plist$(ECHO_END)
