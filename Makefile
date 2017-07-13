include theos/makefiles/common.mk

AGGREGATE_NAME = KeyboardSwitchs
SUBPROJECTS = AutoCapital AutoCorrect CheckSpelling CapsLock DotShortcut

include $(THEOS_MAKE_PATH)/aggregate.mk
