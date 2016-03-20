APP_ABI := armeabi armeabi-v7a arm64-v8a mips x86

ifeq ($(findstring x86,$(TARGET_ARCH_ABI)),)
	APP_STL := stlport_static
endif
