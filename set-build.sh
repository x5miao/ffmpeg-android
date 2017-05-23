#!/bin/bash

#本脚本用于设置交叉编译环境并编译libmedia各子模块，用户请根据自身的编译环境修改
#相应的环境变量.
#libmedia的编译仅在ubuntu下测试通过，推荐使用ubuntu14.04-64TLS.
#注意：不要使用cygwin编译，否则可能出现无法编译的bug.
#set -x

LIBMEDIA_TARGET_PLATFORM=android-22
LIBMEDIA_TARGET_ARCH_ABI=arm64-v8a #armeabi-v7a armeabi

#NDK_ROOT_PATH指向Android NDK开发包的根路径
NDK_ROOT_PATH=/home/xxm/android_dev/android-ndk-r13b
#TOOLCHAIN版本号，请参考${NDK_ROOT_PATH}/toolchains目录下的文件夹名字修改
TOOLCHAIN_VERSION=4.9

#TMPDIR用来指定ffmpeg编译过程中间生成文件的保存目录,编译时请根据用户自己的本地环境指定，
#编译前必须保证该temp文件夹存在
FFMPEG_TMPDIR=/home/xxm/android_dev/workspace/tmp

export LIBMEDIA_TARGET_PLATFORM LIBMEDIA_TARGET_ARCH_ABI FFMPEG_TMPDIR NDK_ROOT_PATH TOOLCHAIN_VERSION

#编译ffmpeg需要按照Android开发者论团的介绍先建立离线交叉编译工具链
#参考网址:https://developer.android.com/ndk/guides/standalone_toolchain.html#wwc
#STANDLONE_ROOT_PATH=/home/xxm/android_dev/workspace/arm-linux-androideabi
#export STANDLONE_ROOT_PATH

#set +x

print_helpmsg(){
	echo "usage:source set-env.sh [option]"
    echo "option is:"
	printf "\t all:  rebuild all opensource library and interface files(GGCodec*.c)\n"
	printf "\t x264: rebuild x264 and interface files\n"
	printf "\t libfdk-aac: rebuild libfdk-aac and interface files\n"
	printf "\t ffmpeg: rebuild ffmpeg and interface files\n"
	printf "\t help: print this message\n\n"
}

build_x264(){
  cd x264 && ./config-android.sh && cd ..
}

build_libfdk-aac(){
  cd libfdk-aac && ./config-android.sh && cd ..
}

build_ffmpeg(){
  cd ffmpeg && ./config-android.sh $1 && cd ..
}

build_module(){
   cp out/Android.mk  out/${LIBMEDIA_TARGET_ARCH_ABI}/
   ndk-build clean && ndk-build all
}

build(){
if test "$1" = "all"; then
  build_x264 && build_libfdk-aac && build_ffmpeg 2
elif test "$1" = "x264"; then
   build_x264 && build_ffmpeg 2
elif test "$1" = "libfdk-aac"; then
   build_libfdk-aac && build_ffmpeg 2
elif test "$1" = "ffmpeg"; then
   build_ffmpeg 2
elif test "$1" = "help"; then
   print_helpmsg && eixt 0
else
   printf "no option, just rebuild interface files\n\n" && print_helpmsg
fi

if test $? -eq 0;then
   build_module
fi
}

build "$@"

