#!/bin/bash
#此脚本用于构建ffmpeg静态库，使用linux版本的ndk，构建系统推荐使用ubuntu14.4 64bit TLS，不要使用cygwin
#set -x


if [ ! $# == 1 ] ; then
    echo "Usage: $0 [0|1|2]"
    exit
fi

export TMPDIR=$FFMPEG_TMPDIR

TARGET_ARCH_OPTION="--arch=arm"
SYSROOT_ARCH_DIRNAME=arch-arm
case $LIBMEDIA_TARGET_ARCH_ABI in
armeabi*v7a)
    SYSROOT_ARCH_DIRNAME=arch-arm
    TOOLCHAIN_PREFIX=${NDK_ROOT_PATH}/toolchains/arm-linux-androideabi-${TOOLCHAIN_VERSION}/prebuilt/linux-x86_64/bin/arm-linux-androideabi-
    TARGET_ARCH_OPTION="--arch=arm --cpu=armv7-a --enable-neon" 
    ;;
armeabi)
    SYSROOT_ARCH_DIRNAME=arch-arm
    TOOLCHAIN_PREFIX=${NDK_ROOT_PATH}/toolchains/arm-linux-androideabi-${TOOLCHAIN_VERSION}/prebuilt/linux-x86_64/bin/arm-linux-androideabi-
    TARGET_ARCH_OPTION="--arch=arm"
    ;;
arm64*v8a)
    SYSROOT_ARCH_DIRNAME=arch-arm64
    TOOLCHAIN_PREFIX=${NDK_ROOT_PATH}/toolchains/aarch64-linux-android-${TOOLCHAIN_VERSION}/prebuilt/linux-x86_64/bin/aarch64-linux-android-
    TARGET_ARCH_OPTION="--arch=aarch64"
    ;;
x86)
    SYSROOT_ARCH_DIRNAME=arch-x86
    TOOLCHAIN_PREFIX=${NDK_ROOT_PATH}/toolchains/x86-${TOOLCHAIN_VERSION}/prebuilt/linux-x86_64/bin/i686-linux-android-
    TARGET_ARCH_OPTION="--arch=x86_32" 
    ;;
x86*64*)
    SYSROOT_ARCH_DIRNAME=arch-x86_64
    TOOLCHAIN_PREFIX=${NDK_ROOT_PATH}/toolchains/x86_64-${TOOLCHAIN_VERSION}/prebuilt/linux-x86_64/bin/x86_64-linux-android-
    TARGET_ARCH_OPTION="--arch=x86_64"
	;;
mips)
    SYSROOT_ARCH_DIRNAME=arch-mips
    TOOLCHAIN_PREFIX=${NDK_ROOT_PATH}/toolchains/mipsel-linux-android-${TOOLCHAIN_VERSION}/prebuilt/linux-x86_64/bin/mipsel-linux-android-
	TARGET_ARCH_OPTION="--arch=mips"
    ;;
mips64)
    SYSROOT_ARCH_DIRNAME=arch-mips64
    TOOLCHAIN_PREFIX=${NDK_ROOT_PATH}/toolchains/mips64el-linux-android-${TOOLCHAIN_VERSION}/prebuilt/linux-x86_64/mips64el-linux-android-
    TARGET_ARCH_OPTION="--arch=mips64"
    ;;
*) 
   echo "unsupported arch(${LIBMEDIA_TARGET_ARCH_ABI}), please change your set-env.sh";
   exit 1
   ;;
esac

PREFIX=${PWD}/../out/${LIBMEDIA_TARGET_ARCH_ABI}
SYSROOT=${NDK_ROOT_PATH}/platforms/${LIBMEDIA_TARGET_PLATFORM}/${SYSROOT_ARCH_DIRNAME}

if [ $1 == "2" ] ; then
echo "********support X264,fdk-aac encoder******"
./configure --prefix=$PREFIX --enable-pic \
--enable-gpl --enable-nonfree \
--enable-cross-compile \
--cross-prefix=${TOOLCHAIN_PREFIX} \
--sysroot=${SYSROOT} \
--target-os=android \
${TARGET_ARCH_OPTION} \
--enable-memalign-hack \
--disable-programs \
--disable-everything \
--disable-encoders \
--disable-decoders \
--enable-libx264 \
--enable-libfdk-aac \
--enable-encoder=aac \
--enable-encoder=libfdk_aac \
--enable-encoder=libx264 \
--enable-decoder=libfdk_aac \
--enable-decoder=aac \
--enable-decoder=aac_latm \
--enable-decoder=h264 \
--disable-demuxers \
--enable-demuxer=aac  \
--enable-demuxer=asf  \
--enable-demuxer=ffmetadata  \
--enable-demuxer=h264  \
--enable-demuxer=mp3  \
--disable-muxers \
--enable-muxer=adts  \
--enable-muxer=h264  \
--enable-muxer=mp4  \
--enable-muxer=pcm_s16le \
--enable-parser=aac \
--enable-parser=aac_latm \
--enable-parser=h264  \
--disable-zlib \
--disable-debug \
--extra-cflags="-DANDROID -I${PREFIX}/include" \
--extra-ldflags="-L${PREFIX}/lib -lx264 -lfdk-aac -Wl,-dynamic-linker=/system/bin/linker -lc -lm -llog" 

elif [ $1 == "1" ] ; then
echo "*******support h264,mp4,aacplus encoder[deprecated]********" 
./configure --prefix=$PREFIX --enable-pic \
--enable-gpl --enable-nonfree \
--enable-cross-compile \
--cross-prefix=$TOOLCHAIN_PREFIX \
--target-os=android \
--sysroot=$SYSROOT \
${TARGET_ARCH_OPTION} \
--disable-debug \
--enable-memalign-hack \
--disable-programs \
--disable-encoders \
--disable-decoders \
--enable-libx264 \
--enable-encoder=aac \
--enable-decoder=aac \
--enable-decoder=aac_latm \
--enable-decoder=h264 \
--disable-demuxers \
--enable-demuxer=aac  \
--enable-demuxer=asf  \
--enable-demuxer=ffmetadata  \
--enable-demuxer=h264  \
--enable-demuxer=latm  \
--disable-muxers \
--enable-muxer=adts  \
--enable-muxer=h264  \
--enable-muxer=mp4  \
--enable-muxer=pcm_s16le \
--enable-parser=aac \
--enable-parser=aac_latm \
--enable-parser=h264  \
--disable-zlib \
--disable-debug \
--extra-cflags=-"DANDROID -I${PREFIX}/include" \
--extra-ldflags="-L${PREFIX}/lib -lx264 -dynamic-linker=/system/bin/linker -lc -lm -llog"

elif [ $1 == "0" ] ; then 
echo "******no support encoder********"
./configure  --prefix=$PREFIX --enable-pic \
--enable-gpl --enable-nonfree \
--enable-cross-compile \
--cross-prefix=${TOOLCHAIN_PREFIX} \
--target-os=linux \
--sysroot=$SYSROOT \
${TARGET_ARCH_OPTION} \
--disable-debug \
--enable-memalign-hack \
--disable-programs \
--disable-encoders \
--disable-decoders \
--enable-decoder=aac \
--enable-decoder=aac_latm \
--enable-decoder=h264 \
--disable-demuxers \
--enable-demuxer=aac  \
--enable-demuxer=asf  \
--enable-demuxer=ffmetadata  \
--enable-demuxer=h264  \
--enable-demuxer=latm  \
--disable-muxers \
--enable-muxer=adts  \
--enable-muxer=h264  \
--enable-muxer=mp4  \
--enable-muxer=pcm_s16le \
--enable-parser=aac \
--enable-parser=aac_latm \
--enable-parser=h264  \
--disable-zlib \
--disable-debug \
--extra-cflags="-DANDROID -I${PREFIX}/include" \
--extra-ldflags="-L${PREFIX}/lib -dynamic-linker=/system/bin/linker -lm -llog -lc"

else  
  echo "*********   check input para. *******" 
  exit
fi

#make clean and disclean can't delete the bellow 4 files,so delete them manual
rm -f compat/strtod.o compat/strtod.d  compat/msvcrt/snprintf.o compat/msvcrt/snprintf.d
make clean
make

#编译的静态库(.a)放在$PREFIX/lib目录下,模块对外头文件存放在$PREFIX/lib目录下
make install

