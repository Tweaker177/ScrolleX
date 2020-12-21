TARGET = iphone:clang:11.2:9.0
ARCHS = arm64 arm64e
DEBUG = 0
FINALPACKAGE = 1
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ScrolleX
ScrolleX_FILES = Tweak.xm
ScrolleX_FRAMEWORKS = UIKit Foundation
ScrolleX_EXTRA_FRAMEWORKS += Cephei
ScrolleX_LDFLAGS = -lCSColorPicker
ScrolleX_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 com.apple.springboard"
SUBPROJECTS += scrollex
include $(THEOS_MAKE_PATH)/aggregate.mk
