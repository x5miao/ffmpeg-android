# ffmpeg-android

bash script to build ffmpeg dynamic library with x264 and libfdk-aac for android

build enveroment:  
	OS:ubuntu 14.04 64bit TLS  
	NDK: android-ndk-r13b  

usage:source set-build.sh  [option]"  
option can be：  
	    all:  cross-compile all components and rebuild libmedia.so  
	    x264: cross-compile x264,ffmpeg and rebuild libmedia.so  
	    libfdk-aac: cross-compile libfdk-aac, ffmpeg and rebuild libmedia.so  
	    ffmpeg: cross-compile ffmpeg and rebuild libmedia.so  
	    help: print help message  

FAQ：  
1. how to change android api level and API?  
	change the values of LIBMEDIA_TARGET_PLATFORM and LIBMEDIA_TARGET_ARCH_ABI in set-build.sh to suitable value.
ABI should be equal to the value in TABLE 1 of this page.[url: https://developer.android.com/ndk/guides/abis.html],
PLATFORM should be equal to <platform> in the target path of $NDK/platforms/<platform>  

2. which version do i used in my project?  
	ffmpeg  3.2.2  
	x264    master branch, last update:2017-01-23, http://git.videolan.org/?p=x264.git;a=summary  
	libfdk-aac  https://github.com/mstorsjo/fdk-aac/releases  
   
