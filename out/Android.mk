LOCAL_PATH := $(call my-dir)

#define a macro to define prebuilt static library
define my_import_prebuilt_lib
include $(CLEAR_VARS)
LOCAL_MODULE:=$1
LOCAL_SRC_FILES:=$2
LOCAL_EXPORT_C_INCLUDES:=$(LOCAL_PATH)/include
include $(PREBUILT_STATIC_LIBRARY)
endef

$(eval $(call my_import_prebuilt_lib,x264,$(LOCAL_PATH)/lib/libx264.a))
$(eval $(call my_import_prebuilt_lib,fdk-aac,$(LOCAL_PATH)/lib/libfdk-aac.a))
$(eval $(call my_import_prebuilt_lib,avcodec,$(LOCAL_PATH)/lib/libavcodec.a))
$(eval $(call my_import_prebuilt_lib,avdevice,$(LOCAL_PATH)/lib/libavdevice.a))
$(eval $(call my_import_prebuilt_lib,avfilter,$(LOCAL_PATH)/lib/libavfilter.a))
$(eval $(call my_import_prebuilt_lib,avformat,$(LOCAL_PATH)/lib/libavformat.a))
$(eval $(call my_import_prebuilt_lib,avutil,$(LOCAL_PATH)/lib/libavutil.a))
$(eval $(call my_import_prebuilt_lib,postproc,$(LOCAL_PATH)/lib/libpostproc.a))
$(eval $(call my_import_prebuilt_lib,swresample,$(LOCAL_PATH)/lib/libswresample.a))
$(eval $(call my_import_prebuilt_lib,swscale,$(LOCAL_PATH)/lib/libswscale.a))

