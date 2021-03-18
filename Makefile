TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard
# DEBUG=0
# FINALPACKAGE=1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = joe

joe_FILES = Tweak.xm
joe_CFLAGS = -fobjc-arc
joe_FRAMEWORKS = Foundation UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += joeprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
