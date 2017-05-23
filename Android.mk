LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := Media
LOCAL_SRC_FILES := 
LOCAL_CFLAGS := -Wall -Wno-deprecated -DANDROID=1
LOCAL_LDLIBS := -llog
LOCAL_C_INCLUDES := $(LOCAL_PATH)/include  $(LOCAL_PATH)
#LOCAL_LDLIBS := -lstdc++
LOCAL_WHOLE_STATIC_LIBRARIES := x264 fdk-aac avcodec avdevice avformat \
    avutil avfilter swresample swscale postproc
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/include
include $(BUILD_SHARED_LIBRARY)

include $(LOCAL_PATH)/out/$(TARGET_ARCH_ABI)/Android.mk

