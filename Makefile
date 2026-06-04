TARGET := iphone:clang:15.5:14.0
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = Music

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MoreRecentSongsPlz

MoreRecentSongsPlz_FILES = Tweak.x
MoreRecentSongsPlz_CFLAGS = -fobjc-arc
MoreRecentSongsPlz_FRAMEWORKS = UIKit Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
