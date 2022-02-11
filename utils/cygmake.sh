#!/bin/bash
set -x -e
mkdir -p libs bin
CC=clang
CPP=clang++
AR=ar
STRIP=strip
CFLAGS="-static"

$CPP $CFLAGS -O3 -std=c++17 -stdlib=libc++ -Iinclude -I../include -c \
    new.cpp \
    files.cpp \
    misc.cpp \
    selinux.cpp \
    logging.cpp \
    xwrap.cpp \
    stream.cpp
$AR rcs libutils.a *.o
rm -f *.o
