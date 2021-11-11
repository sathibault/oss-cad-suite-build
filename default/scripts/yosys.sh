cd yosys
if  [ ${ARCH_BASE} == 'darwin' ]; then
	make config-clang
	sed -i -re "s,CXX = clang,CXX = ${CC},g" Makefile
	sed -i -re "s,LD = clang\+\+,LD = ${CXX},g" Makefile

elif [ ${ARCH} == 'linux-x64' ]; then
	mkdir -p frontends/ghdl
	cp -R ../ghdl-yosys-plugin/src/* frontends/ghdl
	make config-clang
	echo 'ENABLE_GHDL := 1' > Makefile.conf
	echo "GHDL_PREFIX := $(pwd)/../ghdl${INSTALL_PREFIX}" >> Makefile.conf

elif [ ${ARCH} == 'windows-x64' ]; then
	echo 'CONFIG := gcc-static' > Makefile.conf
	echo 'CXX = x86_64-w64-mingw32-g++' >> Makefile.conf
	echo 'CXXFLAGS += -D_POSIX_SOURCE -DYOSYS_WIN32_UNIX_DIR' >> Makefile.conf
	echo 'EXE = .exe' >> Makefile.conf
	echo 'ENABLE_ZLIB := 0' >> Makefile.conf
	echo 'ENABLE_PLUGINS := 0' >> Makefile.conf
	echo 'ENABLE_READLINE := 0' >> Makefile.conf
	echo 'ENABLE_TCL := 0' >> Makefile.conf
	echo 'ENABLE_GHDL := 1' >> Makefile.conf

        GHDLDIR=$(realpath ${OUTPUT_DIR}/../ghdl${INSTALL_PREFIX})
	echo "GHDL_PREFIX := ${GHDLDIR}" >> Makefile.conf
	mkdir -p frontends/ghdl
	cp -R ../ghdl-yosys-plugin/src/* frontends/ghdl
	# whoa, hack for missing functions needed for libgnat.a
	echo 'extern "C" __int64 __imp__ftelli64(FILE *s) { return _ftelli64(s); }' >> frontends/ghdl/ghdl.cc
	echo 'extern "C" __int64 __imp__fseeki64(FILE *s, __int64 offset, int origin) { return _fseeki64(s,offset,origin); }' >> frontends/ghdl/ghdl.cc

#	echo 'LDLIBS := -static' >> Makefile.conf
#	echo 'ABCMKARGS=CC="$(CC)" CXX="$(CXX)" LD="$(LD)" ABC_USE_LIBSTDCXX=1 LIBS="-lm -lpthread -static" OPTFLAGS="-O" ARCHFLAGS="-DABC_USE_STDINT_H -DABC_NO_DYNAMIC_LINKING=1 -Wno-unused-but-set-variable $(ARCHFLAGS)"' >> Makefile.conf
	echo 'DISABLE_ABC_THREADS := 1' >> Makefile.conf
	echo 'ARCHFLAGS = -DWIN32_NO_DLL -DHAVE_STRUCT_TIMESPEC' >> Makefile.conf

	sed 's|PYTHON := \$(shell cygpath -w -m \$(PREFIX)/bin/python3)|PYTHON := /usr/bin/python3|g' -i backends/smt2/Makefile.inc
else
	make config-gcc
	sed -i -re "s,CXX = gcc,CXX = ${CC},g" Makefile
	sed -i -re "s,LD = gcc,LD = ${CC},g" Makefile
fi
make PREFIX=${INSTALL_PREFIX} DESTDIR=${OUTPUT_DIR} install -j${NPROC}
pushd ${OUTPUT_DIR}${INSTALL_PREFIX} 
if [ ${ARCH} == 'windows-x64' ]; then
    ROOTDIR=$(realpath $PKG_CONFIG_PATH/../..)
    cp ${ROOTDIR}/bin/libwinpthread-1.dll ./bin
else
	mkdir -p lib
	ln -s ../bin/yosys-abc lib/
fi
popd
