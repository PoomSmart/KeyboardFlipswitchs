PACKAGE_VERSION = 1.0.0
TARGET = iphone:clang:latest:11.0

include $(THEOS)/makefiles/common.mk

AGGREGATE_NAME = KeyboardSwitchs
SUBPROJECTS = AutoCapital AutoCorrect CheckSpelling CapsLock DotShortcut

include $(THEOS_MAKE_PATH)/aggregate.mk
