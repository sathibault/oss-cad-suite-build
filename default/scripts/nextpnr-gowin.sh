cd nextpnr
yum install -y pip
pip install apycula
patch -p1 < ${PATCHES_DIR}/nextpnr-cmakelists.diff
if [ ${ARCH} == 'windows-x64' ]; then
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} \
      -DPYTHON_INCLUDE_DIR=${BUILD_DIR}/python3${INSTALL_PREFIX}/include/python3.8 \
      -DPYTHON_LIBRARY=${BUILD_DIR}/python3${INSTALL_PREFIX}/lib/libpython3.8${SHARED_EXT} \
      -DARCH=gowin \
      -DSTATIC_BUILD=ON \
      -DBoost_USE_STATIC_LIBS=ON \
      -DBUILD_GUI=OFF -DUSE_IPO=OFF . -DBBA_IMPORT=${BUILD_DIR}/nextpnr-bba/nextpnr/bba/bba-export.cmake
else
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} \
      -DPYTHON_INCLUDE_DIR=${BUILD_DIR}/python3${INSTALL_PREFIX}/include/python3.8 \
      -DPYTHON_LIBRARY=${BUILD_DIR}/python3${INSTALL_PREFIX}/lib/libpython3.8${SHARED_EXT} \
      -DARCH=gowin \
      -DBUILD_GUI=ON -DUSE_IPO=OFF . -DBBA_IMPORT=${BUILD_DIR}/nextpnr-bba/nextpnr/bba/bba-export.cmake
fi
make DESTDIR=${OUTPUT_DIR} -j${NPROC} install
${STRIP} ${OUTPUT_DIR}${INSTALL_PREFIX}/bin/nextpnr-gowin${EXE}
if [ ${ARCH} == 'windows-x64' ]; then
    ROOTDIR=$(realpath $PKG_CONFIG_PATH/../..)
    cp ${ROOTDIR}/bin/libwinpthread-1.dll ${OUTPUT_DIR}${INSTALL_PREFIX}/bin
    cp ${BUILD_DIR}/python3${INSTALL_PREFIX}/lib/libpython3.8${SHARED_EXT} ${OUTPUT_DIR}${INSTALL_PREFIX}/bin
fi
