#!/bin/bash
set -x -e
mkdir -p libs bin
CC=clang
CPP=clang++
AR=ar
STRIP=strip
CFLAGS="-static"

magisklib(){
$CPP $CFLAGS -O3 -std=c++17 -stdlib=libc++ -I../include -I../utils/include -Idtc/libfdt -I../external/zopfli/src -I../external/mincrypt/include -c \
    bootimg.cpp \
    hexpatch.cpp \
    compress.cpp \
    format.cpp \
    dtb.cpp \
    ramdisk.cpp \
    pattern.cpp \
    cpio.cpp
$AR rcs libmagiskboot.a *.o
rm -f *.o

$CPP $CFLAGS -O3 -std=c++17 -stdlib=libc++ -I../include -I../utils/include -Idtc/libfdt -I../external/zopfli/src -I../external/mincrypt/include -c main.cpp
}

magisklib
$CPP -static -std=c++17 -stdlib=libc++ -o magiskboot.exe main.o libmagiskboot.a dtc/libfdt/libfdt.a ../libs/libfmt.a ../libs/libbzip2.a ../utils/libutils.a /usr/local/lib/liblzma.a ../libs/libz.a /usr/local/lib/liblz4.a ../libs/libzopfli.a ../libs/libmincrypt.a -lpthread -lrt