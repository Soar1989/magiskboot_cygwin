CC = clang
CXX = clang++

override CFLAGS :=  $(CFLAGS) -static -O3 -std=c17 -Wno-unused -Wno-unused-parameter -DHAVE_CONFIG_H -Wno-implicit-function-declaration
override CXXFLAGS :=  $(CXXFLAGS) -static -O3 -std=c++17 -stdlib=libc++

override LDFLAGS := $(LDFLAGS) ke
INCLUDES := -Iinclude -Iutils/include -Idtc/libfdt -Izopfli/src -Imincrypt/include -Izlib -Ixz/src/liblzma/api -DSIG_SETMASK=0
LIBLZMA_INCLUDES = \
        -Ixz_config \
        -Ixz/src/common \
        -Ixz/src/liblzma/api \
        -Ixz/src/liblzma/check \
        -Ixz/src/liblzma/common \
        -Ixz/src/liblzma/delta \
        -Ixz/src/liblzma/lz \
        -Ixz/src/liblzma/lzma \
        -Ixz/src/liblzma/rangecoder \
        -Ixz/src/liblzma/simple \
        -Ixz/src/liblzma

LIBMAGISKBOOT_SRC = magiskboot/bootimg.cpp \
        magiskboot/hexpatch.cpp \
        magiskboot/compress.cpp \
        magiskboot/format.cpp \
        magiskboot/dtb.cpp \
        magiskboot/ramdisk.cpp \
        magiskboot/pattern.cpp \
        magiskboot/cpio.cpp \
        magiskboot/main.cpp

LIBMAGISKBOOT_OBJ := $(patsubst %.cpp,obj/%.o,$(LIBMAGISKBOOT_SRC))

LIBUTILS_SRC = utils/new.cpp \
        utils/files.cpp \
        utils/misc.cpp \
        utils/selinux.cpp \
        utils/logging.cpp \
        utils/xwrap.cpp \
        utils/stream.cpp

LIBUTILS_OBJ := $(patsubst %.cpp,obj/%.o,$(LIBUTILS_SRC))

DTC_PATH = ./dtc
BZIP2_PATH = ./bzip2
ZOPFLI_PATH = ./zopfli
FMTLIB_PATH = ./fmtlib
LZ4_PATH = ./lz4

LIBMINCRYPT_SRC = mincrypt/dsa_sig.c \
        mincrypt/p256.c \
        mincrypt/p256_ec.c \
        mincrypt/p256_ecdsa.c \
        mincrypt/rsa.c \
        mincrypt/sha.c \
        mincrypt/sha256.c

LIBMINCRYPT_OBJ := $(patsubst %.c,obj/%.o,$(LIBMINCRYPT_SRC))

# We suggest use cygwin libz-dev instead this
LIBZ_SRC = zlib/adler32.c \
        zlib/compress.c \
        zlib/cpu_features.c \
        zlib/crc32.c \
        zlib/deflate.c \
        zlib/gzclose.c \
        zlib/gzlib.c \
        zlib/gzread.c \
        zlib/gzwrite.c \
        zlib/infback.c \
        zlib/inflate.c \
        zlib/inftrees.c \
        zlib/inffast.c \
        zlib/trees.c \
        zlib/uncompr.c \
        zlib/zutil.c

LIBZ_OBJ := $(patsubst %.c,obj/%.o,$(LIBZ_SRC))

LIBLZMA_SRC = xz/src/common/tuklib_cpucores.c \
        xz/src/common/tuklib_exit.c \
        xz/src/common/tuklib_mbstr_fw.c \
        xz/src/common/tuklib_mbstr_width.c \
        xz/src/common/tuklib_open_stdxxx.c \
        xz/src/common/tuklib_physmem.c \
        xz/src/common/tuklib_progname.c \
        xz/src/liblzma/check/check.c \
        xz/src/liblzma/check/crc32_fast.c \
        xz/src/liblzma/check/crc32_table.c \
        xz/src/liblzma/check/crc64_fast.c \
        xz/src/liblzma/check/crc64_table.c \
        xz/src/liblzma/check/sha256.c \
        xz/src/liblzma/common/alone_decoder.c \
        xz/src/liblzma/common/alone_encoder.c \
        xz/src/liblzma/common/auto_decoder.c \
        xz/src/liblzma/common/block_buffer_decoder.c \
        xz/src/liblzma/common/block_buffer_encoder.c \
        xz/src/liblzma/common/block_decoder.c \
        xz/src/liblzma/common/block_encoder.c \
        xz/src/liblzma/common/block_header_decoder.c \
        xz/src/liblzma/common/block_header_encoder.c \
        xz/src/liblzma/common/block_util.c \
        xz/src/liblzma/common/common.c \
        xz/src/liblzma/common/easy_buffer_encoder.c \
        xz/src/liblzma/common/easy_decoder_memusage.c \
        xz/src/liblzma/common/easy_encoder.c \
        xz/src/liblzma/common/easy_encoder_memusage.c \
        xz/src/liblzma/common/easy_preset.c \
        xz/src/liblzma/common/filter_buffer_decoder.c \
        xz/src/liblzma/common/filter_buffer_encoder.c \
        xz/src/liblzma/common/filter_common.c \
        xz/src/liblzma/common/filter_decoder.c \
        xz/src/liblzma/common/filter_encoder.c \
        xz/src/liblzma/common/filter_flags_decoder.c \
        xz/src/liblzma/common/filter_flags_encoder.c \
        xz/src/liblzma/common/hardware_cputhreads.c \
        xz/src/liblzma/common/hardware_physmem.c \
        xz/src/liblzma/common/index.c \
        xz/src/liblzma/common/index_decoder.c \
        xz/src/liblzma/common/index_encoder.c \
        xz/src/liblzma/common/index_hash.c \
        xz/src/liblzma/common/outqueue.c \
        xz/src/liblzma/common/stream_buffer_decoder.c \
        xz/src/liblzma/common/stream_buffer_encoder.c \
        xz/src/liblzma/common/stream_decoder.c \
        xz/src/liblzma/common/stream_encoder.c \
        xz/src/liblzma/common/stream_encoder_mt.c \
        xz/src/liblzma/common/stream_flags_common.c \
        xz/src/liblzma/common/stream_flags_decoder.c \
        xz/src/liblzma/common/stream_flags_encoder.c \
        xz/src/liblzma/common/vli_decoder.c \
        xz/src/liblzma/common/vli_encoder.c \
        xz/src/liblzma/common/vli_size.c \
        xz/src/liblzma/delta/delta_common.c \
        xz/src/liblzma/delta/delta_decoder.c \
        xz/src/liblzma/delta/delta_encoder.c \
        xz/src/liblzma/lz/lz_decoder.c \
        xz/src/liblzma/lz/lz_encoder.c \
        xz/src/liblzma/lz/lz_encoder_mf.c \
        xz/src/liblzma/lzma/fastpos_table.c \
        xz/src/liblzma/lzma/fastpos_tablegen.c \
        xz/src/liblzma/lzma/lzma2_decoder.c \
        xz/src/liblzma/lzma/lzma2_encoder.c \
        xz/src/liblzma/lzma/lzma_decoder.c \
        xz/src/liblzma/lzma/lzma_encoder.c \
        xz/src/liblzma/lzma/lzma_encoder_optimum_fast.c \
        xz/src/liblzma/lzma/lzma_encoder_optimum_normal.c \
        xz/src/liblzma/lzma/lzma_encoder_presets.c \
        xz/src/liblzma/rangecoder/price_table.c \
        xz/src/liblzma/rangecoder/price_tablegen.c \
        xz/src/liblzma/simple/arm.c \
        xz/src/liblzma/simple/armthumb.c \
        xz/src/liblzma/simple/ia64.c \
        xz/src/liblzma/simple/powerpc.c \
        xz/src/liblzma/simple/simple_coder.c \
        xz/src/liblzma/simple/simple_decoder.c \
        xz/src/liblzma/simple/simple_encoder.c \
        xz/src/liblzma/simple/sparc.c \
        xz/src/liblzma/simple/x86.c

LIBLZMA_OBJ := $(patsubst %.c,obj/%.o,$(LIBLZMA_SRC))

FMTLIB_SRC = fmtlib/src/format.cc
FMTLIB_OBJ = $(patsubst %.cc,obj/%.o,$(FMTLIB_SRC))


.PHONY: all libmagiskboot.a

all: libbz2.a libfdt.a libzopfil.a fmtlib.a liblz4.a liblzma.a  libmincrypt.a libutils.a libmagiskboot.a magiskboot.exe

magiskboot.exe:
	@echo "    LINKING EXECUTABLE BINARY magiskboot"
	sh -c "clang++ -static -stdlib=libc++ -o magiskboot.exe libmagiskboot.a libfdt.a fmtlib.a libbz2.a -lz libutils.a liblzma.a liblz4.a libzopfli.a libmincrypt.a -lpthread -lrt"

obj/%.o: %.c
	@mkdir -p `dirname $@`
	@echo "    CC    $@"
	@$(CC) $(CFLAGS) $(INCLUDES) $(LIBLZMA_INCLUDES) -c $< -o $@

obj/%.o: %.cc
	@mkdir -p `dirname $@`
	@echo "    CPP   $@"
	@$(CXX) $(CXXFLAGS) $(INCLUDES) -fno-exceptions -UNDEBUG -Ifmtlib/include -c $< -o $@

obj/%.o: %.cpp
	@mkdir -p `dirname $@`
	@echo "    CPP   $@"
	@$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@


# libmagiskboot static libary
libmagiskboot.a: $(LIBMAGISKBOOT_OBJ)
	@echo "    AR    libmagiskboot.a"
	@ar rcs $@ $^

libutils.a: $(LIBUTILS_OBJ)
	@echo "    AR    libutils.a"
	@ar rcs $@ $^

libmincrypt.a: $(LIBMINCRYPT_OBJ)
	@echo "    AR    libmincrypt.a"
	@ar rcs $@ $^

libz.a: $(LIBZ_OBJ)
	@echo "    AR    libz.a"
	@ar rcs $@ $^

liblzma.a: $(LIBLZMA_OBJ)
	@echo "    AR    liblzma.a"
	@ar rcs $@ $^

libfdt.a:
	cd $(DTC_PATH) && $(MAKE) libfdt
	mv $(DTC_PATH)/libfdt/libfdt.a ./

libbz2.a:
	cd $(BZIP2_PATH) && $(MAKE) libbz2.a
	mv $(BZIP2_PATH)/libbz2.a ./

libzopfil.a:
	cd $(ZOPFLI_PATH) && $(MAKE) libzopfli.a
	mv $(ZOPFLI_PATH)/libzopfli.a ./

fmtlib.a: $(FMTLIB_OBJ)
	@echo "    AR    fmtlib.a"
	@ar rcs $@ $^

liblz4.a:
	cd $(LZ4_PATH) && $(MAKE) lib
	mv $(LZ4_PATH)/lib/liblz4.a ./

# Remove all libraries and binaries
clean:
	@echo "    CLEAN";
	@echo "    RM    all"
	@cd $(DTC_PATH) && $(MAKE) clean
	@cd $(BZIP2_PATH) && $(MAKE) clean
	@cd $(ZOPFLI_PATH) && $(MAKE) clean
	cd $(LZ4_PATH) && $(MAKE) clean
	@rm -f magiskboot.exe *.a *.o $(LIBMAGISKBOOT_OBJ)
	@echo "    RM    obj"
	@rm -rf obj/
